import 'pokemon_type.dart';
import 'pokemon_stat.dart';

class Pokemon {
  const Pokemon({
    required this.id,
    required this.name,
    required this.nationalDexNumber,
    required this.types,
    this.imageUrl,
    this.artworkUrl,
    this.generationId,
    this.stats = const [],
    this.baseStatTotal = 0,
  });

  final int id;
  final String name;
  final int nationalDexNumber;
  final List<PokemonType> types;
  // imageUrl es el sprite (catálogo), artworkUrl es la imagen oficial (detalle)
  final String? imageUrl;
  final String? artworkUrl;
  final int? generationId;
  final List<PokemonStat> stats;
  final int baseStatTotal;
}
