import 'pokemon_dto.dart';

/// Es el detalle de un Pokemon igual que como llega de la API
/// Trae nombre, tipos, imagenes y estadisticas para poder mostrar las formas
class PokemonDetailDto {
  final int id;
  final String nombre;
  final int altura;
  final int peso;
  final List<PokemonTypeDto> tipos;
  final String? sprite;
  final String? artwork;
  final String? spriteShiny;
  final String? artworkShiny;
  final List<PokemonStatDto> estadisticas;
  final List<PokemonAbilityDto> habilidades;
  final List<PokemonMoveDto> movimientos;
  final List<String> gruposHuevo;
  final List<PokemonFormDto> formas;
  final List<PokemonEvolutionDto> evoluciones;

  const PokemonDetailDto({
    required this.id,
    required this.nombre,
    required this.altura,
    required this.peso,
    required this.tipos,
    required this.sprite,
    required this.artwork,
    required this.spriteShiny,
    required this.artworkShiny,
    required this.estadisticas,
    required this.habilidades,
    required this.movimientos,
    required this.gruposHuevo,
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
      nombre: json['name'] as String,
      altura: json['height'] as int? ?? 0,
      peso: json['weight'] as int? ?? 0,
      // se reusan los DTO de tipos y estadisticas del catalogo
      tipos: (json['pokemontypes'] as List<dynamic>? ?? [])
          .map((t) => PokemonTypeDto.fromJson(t as Map<String, dynamic>))
          .toList(),
      sprite: primeraImagen?['sprite'] as String?,
      artwork: primeraImagen?['artwork'] as String?,
      spriteShiny: primeraImagen?['shiny'] as String?,
      artworkShiny: primeraImagen?['artworkShiny'] as String?,
      estadisticas: (json['pokemonstats'] as List<dynamic>? ?? [])
          .map((s) => PokemonStatDto.fromJson(s as Map<String, dynamic>))
          .toList(),
      habilidades: (json['pokemonabilities'] as List<dynamic>? ?? [])
          .map((h) => PokemonAbilityDto.fromJson(h as Map<String, dynamic>))
          .toList(),
      movimientos: (json['pokemonmoves'] as List<dynamic>? ?? [])
          .map((m) => PokemonMoveDto.fromJson(m as Map<String, dynamic>))
          .toList(),
      // solo se guarda el nombre del grupo
      gruposHuevo: (especie?['pokemonegggroups'] as List<dynamic>? ?? [])
          .map((g) => (g as Map<String, dynamic>)['egggroup']['name'] as String)
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
/// esOculta indica si es la habilidad oculta
class PokemonAbilityDto {
  final String nombre;
  final bool esOculta;
  final String? efecto;

  const PokemonAbilityDto({
    required this.nombre,
    required this.esOculta,
    required this.efecto,
  });

  factory PokemonAbilityDto.fromJson(Map<String, dynamic> json) {
    final habilidad = json['ability'] as Map<String, dynamic>;
    // el efecto llega en una lista, se toma el primero si existe
    final textos = habilidad['abilityeffecttexts'] as List<dynamic>? ?? [];
    return PokemonAbilityDto(
      nombre: habilidad['name'] as String,
      esOculta: json['is_hidden'] as bool? ?? false,
      efecto: textos.isNotEmpty
          ? (textos.first as Map<String, dynamic>)['short_effect'] as String?
          : null,
    );
  }
}

/// Un movimiento que aprende el Pokemon en un juego
/// El mismo movimiento se repite por cada juego y metodo
class PokemonMoveDto {
  final String nombre;

  // level-up, machine, tutor, egg
  final String metodo;

  // 0 si no se aprende por nivel
  final int nivel;

  // el juego, por ejemplo scarlet-violet
  final String grupoVersion;

  const PokemonMoveDto({
    required this.nombre,
    required this.metodo,
    required this.nivel,
    required this.grupoVersion,
  });

  factory PokemonMoveDto.fromJson(Map<String, dynamic> json) {
    return PokemonMoveDto(
      nombre: json['move']['name'] as String,
      metodo: json['movelearnmethod']?['name'] as String? ?? '',
      nivel: json['level'] as int? ?? 0,
      grupoVersion: json['versiongroup']?['name'] as String? ?? '',
    );
  }
}

/// Forma del Pokemon, como Mega o regional
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
/// evolucionaDe es el id del Pokemon del que evoluciona, es null si es el primero
/// Los demas campos dicen como evoluciona, son null si no aplican
class PokemonEvolutionDto {
  final int id;
  final String nombre;
  final int? evolucionaDe;

  // level-up, use-item, trade
  final String? trigger;
  final int? nivelMinimo;
  final String? objeto;
  final int? felicidadMinima;

  // day o night
  final String? hora;

  const PokemonEvolutionDto({
    required this.id,
    required this.nombre,
    required this.evolucionaDe,
    required this.trigger,
    required this.nivelMinimo,
    required this.objeto,
    required this.felicidadMinima,
    required this.hora,
  });

  factory PokemonEvolutionDto.fromJson(Map<String, dynamic> json) {

    // si tiene varias formas de evolucionar se toma la primera
    final condiciones = json['pokemonevolutions'] as List<dynamic>? ?? [];

    final condicion = condiciones.isNotEmpty
        ? condiciones.first as Map<String, dynamic>
        : null;
    final hora = condicion?['time_of_day'] as String?;

    return PokemonEvolutionDto(
      id: json['id'] as int,
      nombre: json['name'] as String,
      evolucionaDe: json['evolves_from_species_id'] as int?,
      trigger: condicion?['evolutiontrigger']?['name'] as String?,
      nivelMinimo: condicion?['min_level'] as int?,
      objeto: condicion?['item']?['name'] as String?,
      felicidadMinima: condicion?['min_happiness'] as int?,

      // la API manda texto vacio cuando no depende de la hora
      hora: hora == null || hora.isEmpty ? null : hora,
    );
  }
}