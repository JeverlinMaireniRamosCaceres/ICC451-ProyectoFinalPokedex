import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/local/pokemon_local_datasource.dart';
import '../datasources/remote/pokemon_remote_datasource.dart';
import '../mappers/pokemon_row_mapper.dart';

// Une la base local y la API, la interfaz solo habla con esta clase
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({required this._local, required this._remote});

  final PokemonLocalDataSource _local;
  final PokemonRemoteDataSource _remote;

  @override
  Stream<List<Pokemon>> watchCatalog() {
    return _local.watchCatalog().map((filas) => filas.toEntities());
  }

  @override
  Future<void> refreshCatalog() {
    throw UnimplementedError();
  }

  @override
  Future<void> fetchNextPage() {
    throw UnimplementedError();
  }
}
