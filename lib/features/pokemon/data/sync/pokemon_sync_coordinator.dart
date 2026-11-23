import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/database/app_database.dart';
import '../datasources/local/pokemon_local_datasource.dart';
import '../datasources/remote/pokemon_remote_datasource.dart';
import '../mappers/pokemon_dto_mapper.dart';
import '../dtos/pokemon_dto.dart';
import '../mappers/pokemon_detail_dto_mapper.dart';

import '../../../../core/errors/failure.dart';

/// Son los cuatro valores posibles de la columna de estado para la sincronizacion
abstract final class SyncStatus {

  // termino bien y falta catalogo por descarga
  static const String idle = 'idle';

  // se esta descargando una pagina
  static const String syncing = 'syncing';

  // todos los pokemon se descargaron
  static const String complete = 'complete';

  // fallo la ultima pagina
  static const String error = 'error';
}

/// Esta clase es donde se coordina la sincronización del catálogo desde la pokeapi hacia la base local
/// La interfaz no lee desde esta clase, solo de la base de datos local
class PokemonSyncCoordinator {
  static const String claveRecurso = 'pokemon_catalog';

  // se piden 20 pokemons por pagina
  static const int tamanoPagina = 20;

  final PokemonRemoteDataSource _remoto;
  final PokemonLocalDataSource _local;
  final AppDatabase _db;

  // Estado que indica la sincronizacion en curso
  // Para que no ocurran dos a la vez
  Future<void>? _sincronizacionActual;

  // Avisa cuando empieza y termina una sincronización, para el indicador
  final void Function(bool sincronizando)? _alCambiarSincronizando;

  // El ultimo error de sincronizacion, para mostrar su mensaje en pantalla
  Failure? ultimoError;

  PokemonSyncCoordinator(
      this._remoto,
      this._local,
      this._db, {
        this._alCambiarSincronizando,
      });

  /// Trae nuevamente la primera pagina para actualizar lo primero que ve el usuario
  /// Es llamada al abrir la app
  Future<void> actualizarCatalogo() {
    return _ejecutarExclusivo(() => _sincronizarPagina(offset: 0));
  }

  /// Trae y guarda la siguiente pagina pendiente
  /// Es usada en el scroll infinito y en el botón Reintentar
  Future<void> obtenerSiguientePagina() {
    return _ejecutarExclusivo(() async {
      final metadatos = await _leerMetadatos();
      if (metadatos?.status == SyncStatus.complete) return;
      await _sincronizarPagina(offset: metadatos?.nextOffset ?? 0);
    });
  }

  /// Descarga el detalle de un Pokemon y lo guarda en la base
  /// Se llama al abrir el detalle
  /// La pantalla no recibe el resultado, lo ve porque observa la base
  Future<void> sincronizarDetalle(int id) async {
    try {
      final dto = await _remoto.obtenerDetallePokemon(id);
      await _local.guardarDetalle(dto.aEntidad());
      debugPrint('[Sync] Detalle $id guardado');
    } catch (e) {
      debugPrint('[Sync] Error en el detalle $id $e');
      rethrow;
    }
  }

  /// Si ya hay una sincronizacion corriendo, devuelve esa en vez de comenzar una nueva
  Future<void> _ejecutarExclusivo(Future<void> Function() accion) {
    final enCurso = _sincronizacionActual;
    if (enCurso != null) return enCurso;

    final tarea = accion().whenComplete(() => _sincronizacionActual = null);
    _sincronizacionActual = tarea;
    return tarea;
  }

  /// Se descarga una pagina de la API y se guarda en la base junto con el nuevo
  /// nextOffset, en una transaccion
  /// Si falla, marca error
  /// el nextOffset es quien dice desde que numero hay que continuar la descarga
  Future<void> _sincronizarPagina({required int offset}) async {
    final anterior = await _leerMetadatos();
    final offsetAnterior = anterior?.nextOffset ?? 0;

    await _guardarEstado(SyncStatus.syncing);
    _alCambiarSincronizando?.call(true);

    try {
      final pagina = await _obtenerConReintentos(offset);

      final pokemones = pagina.aEntidades();

      // El avance nunca retrocede, aunque se vuelva a pedir la primera página
      final nuevoOffset = max(offsetAnterior, offset + pokemones.length);

      final llegoAlFinal = pagina.total > 0
          ? nuevoOffset >= pagina.total
          : pokemones.length < tamanoPagina;

      // El avance y los pokemon se guardan juntos
      // Si algo falla, no se guarda ninguno de los dos
      await _db.transaction(() async {
        if (pokemones.isNotEmpty) {
          await _local.upsertPokemons(pokemones);
        }
        await _db.into(_db.syncMetadata).insertOnConflictUpdate(
          SyncMetadataCompanion(
            resourceKey: const Value(claveRecurso),
            lastSuccessAt: Value(DateTime.now()),
            status: Value(
              llegoAlFinal ? SyncStatus.complete : SyncStatus.idle,
            ),
            nextOffset: Value(nuevoOffset),
          ),
        );
      });

      debugPrint(
        '[Sync] Guardados ${pokemones.length} desde offset $offset, '
            'siguiente $nuevoOffset de ${pagina.total}',
      );
    } catch (e) {
      debugPrint('[Sync] Error en offset $offset $e');
      await _guardarEstado(SyncStatus.error);

      ultimoError = e is Failure ? e : const UnknownFailure();

      // Se vuelve a lanzar el error para que la pantalla sepa que fallo
      // El marcador no se movio, por lo que al reintentar se pide la misma pagina
      rethrow;
    } finally {
      // Se ejecuta siempre, haya funcionado o no
      _alCambiarSincronizando?.call(false);
    }

  }

  // Se intenta pedir la pagina hasta 3 veces
  // Entre cada intento espera 2 elevado al numero de intento, 1 y luego 2 segundos
  // Si el tercero tambien falla, se lanza el error
  Future<PokemonPageDto> _obtenerConReintentos(int offset) async {
    for (var intento = 0; ; intento++) {
      try {
        return await _remoto.obtenerPaginaPokemon(
          limite: tamanoPagina,
          offset: offset,
        );
      } catch (e) {
        if (intento == 2) rethrow;
        debugPrint('[Sync] Fallo el intento ${intento + 1}, reintentando');
        await Future.delayed(Duration(seconds: pow(2, intento).toInt()));
      }
    }
  }

  Future<SyncMetadataData?> _leerMetadatos() {
    return (_db.select(_db.syncMetadata)
      ..where((m) => m.resourceKey.equals(claveRecurso)))
        .getSingleOrNull();
  }

  /// Solo cambia el estado, sin modificar el avance ni la fecha
  Future<void> _guardarEstado(String estado) {
    return _db.into(_db.syncMetadata).insertOnConflictUpdate(
      SyncMetadataCompanion(
        resourceKey: const Value(claveRecurso),
        status: Value(estado),
      ),
    );
  }
}