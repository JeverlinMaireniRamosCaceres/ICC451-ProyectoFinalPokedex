import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/local/pokemon_local_datasource.dart';
import '../mappers/pokemon_row_mapper.dart';
import '../sync/pokemon_sync_coordinator.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../mappers/pokemon_detail_row_mapper.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import '../../../../core/cache/cache_imagenes.dart';

// Une la base local y la API, la interfaz solo habla con esta clase
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(
      {required this._local, required this._coordinadorSincronizacion});

  final PokemonLocalDataSource _local; // para leer la base de datos local
  final PokemonSyncCoordinator _coordinadorSincronizacion; // para hacer la sincronizacion con la API
  // Para que no corran dos recorridos de favoritos a la vez
  Future<void>? _sincronizandoFavoritos;

  @override
  Stream<List<Pokemon>> observarCatalogo({
    String busqueda = '',
    String? tipo,
    int? generacion,
    OrdenCatalogo orden = OrdenCatalogo.numero,
  }) {
    return _local
        .observarCatalogo(
      busqueda: busqueda,
      tipo: tipo,
      generacion: generacion,
      orden: orden,
    )
        .map((filas) => filas.aEntidades());
  }

  @override
  Stream<SyncState> observarEstadoSincronizacion() {
    return _local
        .observarMetadatosSincronizacion(PokemonSyncCoordinator.claveRecurso)
        .map((m) => _aSyncState(m?.status));
  }

  // El string de la base se traduce al enum del dominio
  SyncState _aSyncState(String? estado) {
    return switch (estado) {
      SyncStatus.syncing => SyncState.sincronizando,
      SyncStatus.complete => SyncState.completo,
      SyncStatus.error => SyncState.error,
      _ => SyncState.inactivo,
    };
  }

  @override
  Future<void> actualizarCatalogo() =>
      _coordinadorSincronizacion.actualizarCatalogo();

  @override
  Future<void> obtenerSiguientePagina() =>
      _coordinadorSincronizacion.obtenerSiguientePagina();

  @override
  Failure? get ultimoError => _coordinadorSincronizacion.ultimoError;

  @override
  Stream<PokemonDetail?> observarDetalle(int id) {
    return _local.observarDetalle(id).map((fila) => fila?.aEntidad());
  }

  @override
  Future<void> sincronizarDetalle(int id) =>
      _coordinadorSincronizacion.sincronizarDetalle(id);

  @override
  Stream<Set<int>> observarIdsFavoritos() => _local.observarIdsFavoritos();

  @override
  Stream<List<Pokemon>> observarFavoritos() {
    return _local.observarFavoritos().map((filas) => filas.aEntidades());
  }

  @override
  Future<void> alternarFavorito(int pokemonId) async {
    await _local.alternarFavorito(pokemonId);
// Si se agregó uno, se descarga su detalle en segundo plano para tenerlo sin conexión
// No se espera, así el favorito se guarda y se refleja de inmediato (RF-FAV-04)
    unawaited(sincronizarDetallesFavoritos());
  }

  @override
  Future<void> sincronizarDetallesFavoritos() {
// Si ya hay un recorrido en curso se devuelve ese en vez de empezar otro
    return _sincronizandoFavoritos ??= _descargarDetallesFavoritos()
        .whenComplete(() => _sincronizandoFavoritos = null);
  }

// Descarga de uno en uno los detalles que faltan, para no cargar la API
// Se vuelve a consultar qué falta en cada vuelta, así incluye los favoritos
// que se marquen mientras corre y termina solo cuando ya no queda ninguno
// Al final guarda las imágenes de los favoritos, para verlos sin conexión
  Future<void> _descargarDetallesFavoritos() async {
    while (true) {
      final pendientes = await _local.favoritosSinDetalle();
      if (pendientes.isEmpty) break;

      try {
        await _coordinadorSincronizacion.sincronizarDetalle(pendientes.first);
      } catch (e) {
// Lo más probable es que no haya red, se reintenta cuando regrese
        debugPrint('[Favoritos] No se pudo descargar el detalle ${pendientes
            .first} $e');
        return;
      }
    }

    await _descargarImagenesFavoritos();
  }

// Guarda en el teléfono el sprite y el artwork de cada favorito
// getSingleFile devuelve el archivo guardado si ya está, y solo descarga si falta
// Las versiones shiny no se precargan para no gastar espacio, se guardan al verlas
  Future<void> _descargarImagenesFavoritos() async {
    final favoritos = (await _local
        .observarFavoritos()
        .first).aEntidades();

    for (final pokemon in favoritos) {
      for (final url in [pokemon.imageUrl, pokemon.artworkUrl]) {
        if (url == null) continue;
        try {
          await CacheImagenes.gestor.getSingleFile(url);
        } catch (e) {
// Sin red no tiene sentido seguir con las demás
          debugPrint('[Favoritos] No se pudo guardar la imagen $url $e');
          return;
        }
      }
    }
  }
}