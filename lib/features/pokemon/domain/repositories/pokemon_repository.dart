import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Stream<List<Pokemon>> watchCatalog();

  Future<void> refreshCatalog();

  Future<void> fetchNextPage();
}
