import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_type.dart';
import '../dtos/pokemon_dto.dart';

/// La función de este mapper es convertir los objetos enviados por la API en los modelos que usa la app
/// Este es el único archivo en el que se sabe el formato de la API y el formato de la aplicación
extension PokemonDtoMapper on PokemonDto {
  Pokemon toEntity() {
    // Se compara para ordenar los tipos devueltos por slot
    // Cada pokemon tiene 1 o 2 tipos, el 1 es el principal, el 2 el secundario
    // Se ordena para que el 1 quede primero
    final sortedTypes = [...types]..sort((a, b) => a.slot.compareTo(b.slot));

    return Pokemon(
      id: id,
      name: name,
      nationalDexNumber: speciesId,
      types: sortedTypes.map((t) => t.toEntity()).toList(),

      // Se utiliza el sprite si esta disponile, de lo contrario se utiliza el artwork
      // Se prioriza el sprite porque pesa menos
      imageUrl: sprite ?? artwork,
      generationId: generationId,
    );
  }
}

/// Convierte un tipo enviado por la API en el pokemontype que usa la app
extension PokemonTypeDtoMapper on PokemonTypeDto {
  PokemonType toEntity() {
    return PokemonType(id: typeId, name: typeName);
  }
}

extension PokemonPageDtoMapper on PokemonPageDto {
  /// Convierte los pokemon devueltos a entidades
  List<Pokemon> toEntities() {
    return pokemons.map((p) => p.toEntity()).toList();
  }
}
