import '../../../../core/errors/failure.dart';
import '../../domain/entities/pokemon.dart';

sealed class CatalogState {
  const CatalogState();
}

class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

class CatalogSuccess extends CatalogState {
  const CatalogSuccess(this.pokemons);

  final List<Pokemon> pokemons;
}

class CatalogEmpty extends CatalogState {
  const CatalogEmpty();
}

// Algo falló, se guarda el Failure para mostrar su mensaje
class CatalogError extends CatalogState {
  const CatalogError(this.failure);

  final Failure failure;
}
