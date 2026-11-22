import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_stat.dart';
import '../../domain/entities/pokemon_type.dart';
import '../dtos/pokemon_dto.dart';

/// La función de este mapper es convertir los objetos enviados por la API en los modelos que usa la app
/// Este es el único archivo en el que se sabe el formato de la API y el formato de la aplicación
///
/// Se usan extensiones para agregarle el metodo toEntity a cada DTO sin modificar las clases del DTO
extension PokemonDtoMapper on PokemonDto {
  Pokemon aEntidad() {
    // Se compara para ordenar los tipos devueltos por slot
    // Cada pokemon tiene 1 o 2 tipos, el 1 es el principal, el 2 el secundario
    // Se ordena para que el 1 quede primero
    // hace una copia, para no modificar la lista original del DTO
    final tiposOrdenados = [...tipos]..sort((a, b) => a.slot.compareTo(b.slot));

    // Se convierten las estadisticas una sola vez y se usan para la lista y para el total
    final estadisticasConvertidas = estadisticas.map((s) => s.aEntidad()).toList();

    return Pokemon(
      id: id,
      name: nombre,
      nationalDexNumber: idEspecie, // es el numero de la pokedex
      types: tiposOrdenados.map((t) => t.aEntidad()).toList(),

      // El sprite es para el catálogo y el artwork para el detalle.
      // Si no hay sprite, el catálogo usa el artwork
      imageUrl: sprite ?? artwork,
      artworkUrl: artwork,
      generationId: idGeneracion,
      stats: estadisticasConvertidas,
      // Suma de las 6 estadísticas base, para ordenar el catálogo
      baseStatTotal: estadisticasConvertidas.fold(0, (suma, s) => suma + s.baseStat),
    );
  }
}

/// Convierte un tipo enviado por la API en el pokemontype que usa la app
extension PokemonTypeDtoMapper on PokemonTypeDto {
  PokemonType aEntidad() {
    return PokemonType(id: idTipo, name: nombreTipo);
  }
}

/// Convierte una estadística enviada por la API en el pokemonstat que usa la app
extension PokemonStatDtoMapper on PokemonStatDto {
  PokemonStat aEntidad() {
    return PokemonStat(name: nombre, baseStat: valorBase);
  }
}

extension PokemonPageDtoMapper on PokemonPageDto {
  /// Convierte los pokemon devueltos a entidades
  List<Pokemon> aEntidades() {
    return pokemones.map((p) => p.aEntidad()).toList();
  }
}
