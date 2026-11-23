import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/local/pokemon_local_datasource.dart';
import '../mappers/pokemon_row_mapper.dart';
import '../sync/pokemon_sync_coordinator.dart';
import '../../../../core/errors/failure.dart';

// Une la base local y la API, la interfaz solo habla con esta clase
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({required this._local, required this._coordinadorSincronizacion});

  final PokemonLocalDataSource _local; // para leer la base de datos local
  final PokemonSyncCoordinator _coordinadorSincronizacion; // para hacer la sincronizacion con la API

  @override
  Stream<List<Pokemon>> observarCatalogo({String busqueda = ''}) {
    return _local
        .observarCatalogo(busqueda: busqueda)
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
  Future<void> actualizarCatalogo() => _coordinadorSincronizacion.actualizarCatalogo();

  @override
  Future<void> obtenerSiguientePagina() => _coordinadorSincronizacion.obtenerSiguientePagina();

  @override
  Failure? get ultimoError => _coordinadorSincronizacion.ultimoError;

}
