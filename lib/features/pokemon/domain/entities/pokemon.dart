import 'pokemon_type.dart';

class Pokemon {
  const Pokemon({
    required this.id,
    required this.name,
    required this.nationalDexNumber,
    required this.types,
    this.imageUrl,
    this.generationId,
  });

  final int id;
  final String name;
  final int nationalDexNumber;
  final String? imageUrl;
  final int? generationId;
  final List<PokemonType> types;
}
