import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/local/pokemon_local_datasource.dart';
import '../mappers/pokemon_row_mapper.dart';
import '../sync/pokemon_sync_coordinator.dart';

// Une la base local y la API, la interfaz solo habla con esta clase
class PokemonRepositoryImpl implements PokemonRepository {

  PokemonRepositoryImpl({
    required this._local,
    required this._syncCoordinator,
  });

  final PokemonLocalDataSource _local;
  final PokemonSyncCoordinator _syncCoordinator;

  @override
  Stream<List<Pokemon>> watchCatalog() {
    return _local.watchCatalog().map((filas) => filas.toEntities());
  }

  @override
  Future<void> refreshCatalog() => _syncCoordinator.refreshCatalog();

  @override
  Future<void> fetchNextPage() => _syncCoordinator.fetchNextPage();

}
