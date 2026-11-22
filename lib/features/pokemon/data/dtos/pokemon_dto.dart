/// Es la representación de un Pokémon igual que como llega de la API GraphQL de PokeAPI
class PokemonDto {
  final int id;
  final String nombre;
  final int idEspecie;
  final List<PokemonTypeDto> tipos;
  final String? sprite;
  final String? artwork;
  final int? idGeneracion;
  final List<PokemonStatDto> estadisticas;

  const PokemonDto({
    required this.id,
    required this.nombre,
    required this.idEspecie,
    required this.tipos,
    required this.sprite,
    required this.artwork,
    required this.idGeneracion,
    required this.estadisticas,
  });

  /// Convierte el mapa del JSON en un pokemondto
  /// Si una lista no llega en el JSON, se usa una lista vacia, para que la app no falle
  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    // pokemonsprites es una lista, por eso
    // se toma el primer elemento, si existe
    final imagenes = json['pokemonsprites'] as List<dynamic>? ?? [];
    final primeraImagen = imagenes.isNotEmpty
        ? imagenes.first as Map<String, dynamic>
        : null;

    // datos de la especie
    // pueden estar nulos
    final especie = json['pokemonspecy'] as Map<String, dynamic>?;

    return PokemonDto(
      id: json['id'] as int,
      nombre: json['name'] as String,
      idEspecie: json['pokemon_species_id'] as int,
      tipos: (json['pokemontypes'] as List<dynamic>? ?? [])
          .map((t) => PokemonTypeDto.fromJson(t as Map<String, dynamic>))
          .toList(),
      sprite: primeraImagen?['sprite'] as String?,
      artwork: primeraImagen?['artwork'] as String?,
      idGeneracion: especie?['generation_id'] as int?,
      estadisticas: (json['pokemonstats'] as List<dynamic>? ?? [])
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
  final int idTipo;
  final String nombreTipo;

  const PokemonTypeDto({
    required this.slot,
    required this.idTipo,
    required this.nombreTipo,
  });

  factory PokemonTypeDto.fromJson(Map<String, dynamic> json) {
    final tipo = json['type'] as Map<String, dynamic>;
    return PokemonTypeDto(
      slot: json['slot'] as int,
      idTipo: tipo['id'] as int,
      nombreTipo: tipo['name'] as String,
    );
  }
}

/// Es la estadística base de un Pokemon
/// Todos los pokemones tienen 6, que son: hp, attack, defense, special-attack, special-defense y speed
class PokemonStatDto {
  final String nombre;
  final int valorBase;

  const PokemonStatDto({required this.nombre, required this.valorBase});

  factory PokemonStatDto.fromJson(Map<String, dynamic> json) {
    final estadistica = json['stat'] as Map<String, dynamic>;
    return PokemonStatDto(
      // es el nombre de la estadistica enviado por la API
      nombre: estadistica['name'] as String,
      valorBase: json['base_stat'] as int, // valor de la estadistica
    );
  }
}

/// Lo que devuelve la API al solicitar una pagina del catologo
/// Tiene todos los pokemones de la pagina, ademas del total que tiene la API
class PokemonPageDto {
  final List<PokemonDto> pokemones;
  final int total;

  const PokemonPageDto({required this.pokemones, required this.total});

  /// Convierte el JSON de la respuesta en un PokemonPageDto, con la lista de pokemon de
  /// la pagina y el total
  /// Si una lista no llega en el JSON, se usa una lista vacia, para que la app no falle
  factory PokemonPageDto.fromJson(Map<String, dynamic> data) {
    final lista = data['pokemon'] as List<dynamic>? ?? [];
    final aggregate = data['pokemon_aggregate']?['aggregate'];
    return PokemonPageDto(
      pokemones: lista
          .map((p) => PokemonDto.fromJson(p as Map<String, dynamic>))
          .toList(),
      // si la API no manda el total, se usa 0 en vez de fallar
      total: aggregate?['count'] as int? ?? 0,
    );
  }
}
