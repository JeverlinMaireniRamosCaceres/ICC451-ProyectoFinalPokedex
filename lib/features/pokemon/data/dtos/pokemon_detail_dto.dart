/// Es el detalle de un Pokemon igual que como llega de la API
/// Solo tiene lo que no trae el catalogo
class PokemonDetailDto {
  final int id;
  final int altura;
  final int peso;
  final String? spriteShiny;
  final String? artworkShiny;
  final List<PokemonAbilityDto> habilidades;
  final List<String> movimientos;
  final List<PokemonFormDto> formas;
  final List<PokemonEvolutionDto> evoluciones;

  const PokemonDetailDto({
    required this.id,
    required this.altura,
    required this.peso,
    required this.spriteShiny,
    required this.artworkShiny,
    required this.habilidades,
    required this.movimientos,
    required this.formas,
    required this.evoluciones,
  });

  /// Si una lista no llega en el JSON, se usa una lista vacia
  factory PokemonDetailDto.fromJson(Map<String, dynamic> json) {
    final imagenes = json['pokemonsprites'] as List<dynamic>? ?? [];
    final primeraImagen = imagenes.isNotEmpty
        ? imagenes.first as Map<String, dynamic>
        : null;

    final especie = json['pokemonspecy'] as Map<String, dynamic>?;
    final cadena = especie?['evolutionchain'] as Map<String, dynamic>?;

    return PokemonDetailDto(
      id: json['id'] as int,
      altura: json['height'] as int? ?? 0,
      peso: json['weight'] as int? ?? 0,
      spriteShiny: primeraImagen?['shiny'] as String?,
      artworkShiny: primeraImagen?['artworkShiny'] as String?,
      habilidades: (json['pokemonabilities'] as List<dynamic>? ?? [])
          .map((h) => PokemonAbilityDto.fromJson(h as Map<String, dynamic>))
          .toList(),
      // solo se guarda el nombre del movimiento
      movimientos: (json['pokemonmoves'] as List<dynamic>? ?? [])
          .map((m) => (m as Map<String, dynamic>)['move']['name'] as String)
          .toList(),
      formas: (especie?['pokemons'] as List<dynamic>? ?? [])
          .map((f) => PokemonFormDto.fromJson(f as Map<String, dynamic>))
          .toList(),
      evoluciones: (cadena?['pokemonspecies'] as List<dynamic>? ?? [])
          .map((e) => PokemonEvolutionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Habilidad del Pokemon
/// esOculta es para indicar si es la habilidad oculta
class PokemonAbilityDto {
  final String nombre;
  final bool esOculta;

  const PokemonAbilityDto({required this.nombre, required this.esOculta});

  factory PokemonAbilityDto.fromJson(Map<String, dynamic> json) {
    final habilidad = json['ability'] as Map<String, dynamic>;
    return PokemonAbilityDto(
      nombre: habilidad['name'] as String,
      esOculta: json['is_hidden'] as bool? ?? false,
    );
  }
}

/// Forma del Pokemon, ya sea Mega o regional
/// esPredeterminada es true en la forma normal
class PokemonFormDto {
  final int id;
  final String nombre;
  final bool esPredeterminada;

  const PokemonFormDto({
    required this.id,
    required this.nombre,
    required this.esPredeterminada,
  });

  factory PokemonFormDto.fromJson(Map<String, dynamic> json) {
    return PokemonFormDto(
      id: json['id'] as int,
      nombre: json['name'] as String,
      esPredeterminada: json['is_default'] as bool? ?? false,
    );
  }
}

/// Una especie de la cadena de evolucion
/// evolucionaDe es el id de la especie anterior, es null en la primera
class PokemonEvolutionDto {
  final int id;
  final String nombre;
  final int? evolucionaDe;

  const PokemonEvolutionDto({
    required this.id,
    required this.nombre,
    required this.evolucionaDe,
  });

  factory PokemonEvolutionDto.fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionDto(
      id: json['id'] as int,
      nombre: json['name'] as String,
      evolucionaDe: json['evolves_from_species_id'] as int?,
    );
  }
}