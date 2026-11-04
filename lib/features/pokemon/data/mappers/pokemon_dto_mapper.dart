import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_stat.dart';
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

    final mappedStats = stats.map((s) => s.toEntity()).toList();

    return Pokemon(
      id: id,
      name: name,
      nationalDexNumber: speciesId,
      types: sortedTypes.map((t) => t.toEntity()).toList(),

      // Se utiliza el sprite si esta disponile, de lo contrario se utiliza el artwork
      // Se prioriza el sprite porque pesa menos
      imageUrl: sprite ?? artwork,
      // El artwork se guarda aparte para el detalle (RF-DET-01)
      artworkUrl: artwork,
      generationId: generationId,
      stats: mappedStats,
      // Se calcula aquí una vez para poder ordenar por total en SQL (RF-FIL-03)
      baseStatTotal: mappedStats.fold<int>(0, (sum, s) => sum + s.baseStat),
    );
  }
}

/// Convierte un tipo enviado por la API en el pokemontype que usa la app
extension PokemonTypeDtoMapper on PokemonTypeDto {
  PokemonType toEntity() {
    return PokemonType(id: typeId, name: typeName);
  }
}

/// Convierte una estadística enviada por la API en el pokemonstat que usa la app
extension PokemonStatDtoMapper on PokemonStatDto {
  PokemonStat toEntity() {
    return PokemonStat(name: name, baseStat: baseStat);
  }
}

extension PokemonPageDtoMapper on PokemonPageDto {
  /// Convierte los pokemon devueltos a entidades
  List<Pokemon> toEntities() {
    return pokemons.map((p) => p.toEntity()).toList();
  }
}
