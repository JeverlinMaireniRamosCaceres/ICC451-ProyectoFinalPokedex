/// Es la representación de un Pokémon igual que como llega de la API GraphQL de PokeAPI
class PokemonDto {
  final int id;
  final String name;
  final int speciesId;
  final List<PokemonTypeDto> types;
  final String? sprite;
  final String? artwork;
  final int? generationId;
  final List<PokemonStatDto> stats;

  const PokemonDto({
    required this.id,
    required this.name,
    required this.speciesId,
    required this.types,
    required this.sprite,
    required this.artwork,
    required this.generationId,
    required this.stats,
  });

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    // pokemonsprites es una lista, por eso
    // se toma el primer elemento, si existe
    final sprites = json['pokemonsprites'] as List<dynamic>? ?? [];
    final firstSprite = sprites.isNotEmpty
        ? sprites.first as Map<String, dynamic>
        : null;

    // datos de la especie
    // pueden estar nulos
    final species = json['pokemonspecy'] as Map<String, dynamic>?;

    return PokemonDto(
      id: json['id'] as int,
      name: json['name'] as String,
      speciesId: json['pokemon_species_id'] as int,
      types: (json['pokemontypes'] as List<dynamic>? ?? [])
          .map((t) => PokemonTypeDto.fromJson(t as Map<String, dynamic>))
          .toList(),
      sprite: firstSprite?['sprite'] as String?,
      artwork: firstSprite?['artwork'] as String?,
      generationId: species?['generation_id'] as int?,
      stats: (json['pokemonstats'] as List<dynamic>? ?? [])
          .map((s) => PokemonStatDto.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Es un tipo de Pokemon
/// Cada Pokemon puede tener uno o dos tipos
/// El slot es que indica el orden
/// 1 significa que es el principal, el 2 es el secundario
class PokemonTypeDto {
  final int slot;
  final int typeId;
  final String typeName;

  const PokemonTypeDto({
    required this.slot,
    required this.typeId,
    required this.typeName,
  });

  factory PokemonTypeDto.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as Map<String, dynamic>;
    return PokemonTypeDto(
      slot: json['slot'] as int,
      typeId: type['id'] as int,
      typeName: type['name'] as String,
    );
  }
}

/// Es la estadística base de un Pokemon
/// Todos los pokemones tienen 6, que son: hp, attack, defense, special-attack, special-defense y speed
class PokemonStatDto {
  final String name;
  final int baseStat;

  const PokemonStatDto({required this.name, required this.baseStat});

  factory PokemonStatDto.fromJson(Map<String, dynamic> json) {
    final stat = json['stat'] as Map<String, dynamic>;
    return PokemonStatDto(
      name: stat['name'] as String,
      // es el nombre de la estadistica enviado por la API
      baseStat: json['base_stat'] as int, // valor de la estadistica
    );
  }
}

/// Lo que devuelve la API al solicitar una pagina del catologo
/// Tiene todos los pokemones de la pagina, ademas del total que tiene la API
class PokemonPageDto {
  final List<PokemonDto> pokemons;
  final int totalCount;

  const PokemonPageDto({required this.pokemons, required this.totalCount});

  factory PokemonPageDto.fromJson(Map<String, dynamic> data) {
    final list = data['pokemon'] as List<dynamic>? ?? [];
    final aggregate = data['pokemon_aggregate']?['aggregate'];
    return PokemonPageDto(
      pokemons: list
          .map((p) => PokemonDto.fromJson(p as Map<String, dynamic>))
          .toList(),
      totalCount: aggregate?['count'] as int? ?? 0,
    );
  }
}
