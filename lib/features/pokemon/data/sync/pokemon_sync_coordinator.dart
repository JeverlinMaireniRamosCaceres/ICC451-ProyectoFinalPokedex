import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/database/app_database.dart';
import '../datasources/local/pokemon_local_datasource.dart';
import '../datasources/remote/pokemon_remote_datasource.dart';
import '../mappers/pokemon_dto_mapper.dart';

/// Son los cuatro valores posibles de la columna de estado para la sincronizacion
abstract final class SyncStatus {
  static const String idle = 'idle';
  static const String syncing = 'syncing';
  static const String complete = 'complete';
  static const String error = 'error';
}

/// Esta clase es donde se coordina la sincronización del catálogo desde la pokeapi hacia la base local
/// La interfaz no lee desde esta clase, solo de la base de datos local
class PokemonSyncCoordinator {
  static const String resourceKey = 'pokemon_catalog';
  static const int pageSize = 20;

  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;
  final AppDatabase _db;

  // Estado que indica la sincronizacion en curso
  // Para que no ocurran dos a la vez
  Future<void>? _currentSync;

  // Avisa cuando empieza y termina una sincronización, para el indicador
  final void Function(bool syncing)? _onSyncingChanged;

  PokemonSyncCoordinator(
      this._remote,
      this._local,
      this._db, {
        void Function(bool syncing)? onSyncingChanged,
      }) : _onSyncingChanged = onSyncingChanged;

  /// Trae nuevamente la primera pagina para actualizar lo primero que ve el usuario
  /// Es llamada al abrir la app
  Future<void> refreshCatalog() {
    return _runExclusive(() => _syncPage(offset: 0));
  }

  /// Retorna la siguiente pagina pendiente
  /// Es usada en el scroll infinito y en el botón Reintentar
  Future<void> fetchNextPage() {
    return _runExclusive(() async {
      final metadata = await _readMetadata();
      if (metadata?.status == SyncStatus.complete) return;
      await _syncPage(offset: metadata?.nextOffset ?? 0);
    });
  }

  /// Si ya hay una sincronizacion corriendo, devuelve esa en vez de comenzar una nueva
  Future<void> _runExclusive(Future<void> Function() action) {
    final running = _currentSync;
    if (running != null) return running;

    final future = action().whenComplete(() => _currentSync = null);
    _currentSync = future;
    return future;
  }

  Future<void> _syncPage({required int offset}) async {
    final previous = await _readMetadata();
    final previousOffset = previous?.nextOffset ?? 0;

    await _writeStatus(SyncStatus.syncing);
    _onSyncingChanged?.call(true);

    try {
      final page = await _remote.fetchPokemonPage(
        limit: pageSize,
        offset: offset,
      );
      final pokemons = page.toEntities();

      // El avance nunca retrocede, aunque se vuelva a pedir la primera página
      final newOffset = max(previousOffset, offset + pokemons.length);

      final reachedEnd = page.totalCount > 0
          ? newOffset >= page.totalCount
          : pokemons.length < pageSize;

      // El avance y los pokemon se guardan juntos
      // Si algo falla, no se guarda ninguno de los dos
      await _db.transaction(() async {
        if (pokemons.isNotEmpty) {
          await _local.upsertPokemons(pokemons);
        }
        await _db.into(_db.syncMetadata).insertOnConflictUpdate(
          SyncMetadataCompanion(
            resourceKey: const Value(resourceKey),
            lastSuccessAt: Value(DateTime.now()),
            status: Value(
              reachedEnd ? SyncStatus.complete : SyncStatus.idle,
            ),
            nextOffset: Value(newOffset),
          ),
        );
      });

      debugPrint(
        '[Sync] Guardados ${pokemons.length} desde offset $offset, '
            'siguiente $newOffset de ${page.totalCount}',
      );
    } catch (e) {
      debugPrint('[Sync] Error en offset $offset $e');
      await _writeStatus(SyncStatus.error);
      rethrow;
    } finally {
      // Se ejecuta siempre, haya funcionado o no
      _onSyncingChanged?.call(false);
    }

  }

  Future<SyncMetadataData?> _readMetadata() {
    return (_db.select(_db.syncMetadata)
      ..where((m) => m.resourceKey.equals(resourceKey)))
        .getSingleOrNull();
  }

  /// Solo cambia el estado, sin modificar el avance ni la fecha
  Future<void> _writeStatus(String status) {
    return _db.into(_db.syncMetadata).insertOnConflictUpdate(
      SyncMetadataCompanion(
        resourceKey: const Value(resourceKey),
        status: Value(status),
      ),
    );
  }
}