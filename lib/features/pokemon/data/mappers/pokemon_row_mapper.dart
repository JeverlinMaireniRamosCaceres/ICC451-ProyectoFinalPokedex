import '../../../../core/database/app_database.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_type.dart';
import '../datasources/local/pokemon_local_datasource.dart';

// Convierte lo que entrega la base local en las entidades que usa la app
extension PokemonWithTypesMapper on PokemonWithTypes {
  Pokemon aEntidad() {
    return Pokemon(
      id: pokemon.id,
      name: pokemon.name,
      nationalDexNumber: pokemon.nationalDexNumber,
      types: types.map((t) => t.aEntidad()).toList(),
      imageUrl: pokemon.imageUrl,
      artworkUrl: pokemon.artworkUrl,
      generationId: pokemon.generationId,
      baseStatTotal: pokemon.baseStatTotal,
    );
  }
}

extension TypeRowMapper on TypeRow {
  PokemonType aEntidad() {
    return PokemonType(id: id, name: name);
  }
}

// Convierte la lista completa que entrega observarCatalogo en entidades
extension PokemonWithTypesListMapper on List<PokemonWithTypes> {
  List<Pokemon> aEntidades() {
    return map((p) => p.aEntidad()).toList();
  }
}
