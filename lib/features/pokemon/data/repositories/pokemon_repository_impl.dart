import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/local/pokemon_local_datasource.dart';
import '../mappers/pokemon_row_mapper.dart';
import '../sync/pokemon_sync_coordinator.dart';

// Une la base local y la API, la interfaz solo habla con esta clase
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({required this._local, required this._syncCoordinator});

  final PokemonLocalDataSource _local;
  final PokemonSyncCoordinator _syncCoordinator;

  @override
  Stream<List<Pokemon>> watchCatalog() {
    return _local.watchCatalog().map((filas) => filas.toEntities());
  }

  @override
  Stream<SyncState> watchSyncState() {
    return _local
        .watchSyncMetadata(PokemonSyncCoordinator.resourceKey)
        .map((m) => _aSyncState(m?.status));
  }

  // El string de la base se traduce al enum del dominio
  SyncState _aSyncState(String? status) {
    return switch (status) {
      SyncStatus.syncing => SyncState.syncing,
      SyncStatus.complete => SyncState.complete,
      SyncStatus.error => SyncState.error,
      _ => SyncState.idle,
    };
  }

  @override
  Future<void> refreshCatalog() => _syncCoordinator.refreshCatalog();

  @override
  Future<void> fetchNextPage() => _syncCoordinator.fetchNextPage();
}
