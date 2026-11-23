import 'pokemon_stat.dart';
import 'pokemon_type.dart';

/// Datos del detalle de un Pokemon
/// Tiene nombre, tipos, imagenes y estadisticas porque las formas no estan en el catalogo
class PokemonDetail {
  const PokemonDetail({
    required this.id,
    required this.nombre,
    required this.altura,
    required this.peso,
    this.tipos = const [],
    this.sprite,
    this.artwork,
    this.spriteShiny,
    this.artworkShiny,
    this.estadisticas = const [],
    this.habilidades = const [],
    this.movimientos = const [],
    this.gruposHuevo = const [],
    this.formas = const [],
    this.evoluciones = const [],
  });

  final int id;
  final String nombre;
  // en decimetros, se divide entre 10 para metros
  final int altura;
  // en hectogramos, se divide entre 10 para kilos
  final int peso;
  final List<PokemonType> tipos;
  final String? sprite;
  final String? artwork;
  final String? spriteShiny;
  final String? artworkShiny;
  final List<PokemonStat> estadisticas;
  final List<PokemonAbility> habilidades;
  final List<PokemonMove> movimientos;
  final List<String> gruposHuevo;
  final List<PokemonForm> formas;
  final List<PokemonEvolution> evoluciones;
}

class PokemonAbility {
  const PokemonAbility({
    required this.nombre,
    required this.esOculta,
    this.efecto,
  });

  final String nombre;
  final bool esOculta;

  // resumen del efecto, maximo 160 caracteres
  final String? efecto;
}

class PokemonMove {
  const PokemonMove({
    required this.nombre,
    required this.metodo,
    required this.nivel,
    required this.grupoVersion,
  });

  final String nombre;
  // level-up, machine, tutor, egg
  final String metodo;
  // 0 si no se aprende por nivel
  final int nivel;
  // el juego, por ejemplo scarlet-violet
  final String grupoVersion;
}

class PokemonForm {
  const PokemonForm({
    required this.id,
    required this.nombre,
    required this.esPredeterminada,
  });

  final int id;
  final String nombre;
  final bool esPredeterminada;
}

class PokemonEvolution {
  const PokemonEvolution({
    required this.id,
    required this.nombre,
    this.evolucionaDe,
    this.trigger,
    this.nivelMinimo,
    this.objeto,
    this.felicidadMinima,
    this.hora,
  });

  final int id;
  final String nombre;
  // id del Pokemon del que evoluciona, es null si es el primero de la cadena
  final int? evolucionaDe;
  // como evoluciona, level-up, use-item, trade
  final String? trigger;
  final int? nivelMinimo;
  final String? objeto;
  final int? felicidadMinima;
  // day o night
  final String? hora;
}