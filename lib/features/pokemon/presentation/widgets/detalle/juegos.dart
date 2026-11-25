import '../../../../../core/utils/texto.dart';

// Juegos de PokeAPI del más nuevo al más viejo, con su nombre en español
// Un mapa constante mantiene el orden en que se escribe
const _nombresJuegos = {
  'legends-za': 'Leyendas Pokémon: Z-A',
  'champions': 'Pokémon Champions',
  'scarlet-violet': 'Escarlata y Púrpura',
  'sword-shield': 'Espada y Escudo',
  'brilliant-diamond-shining-pearl': 'Diamante Brillante y Perla Reluciente',
  'lets-go-pikachu-lets-go-eevee': "Let's Go, Pikachu! y Let's Go, Eevee!",
  'ultra-sun-ultra-moon': 'Ultrasol y Ultraluna',
  'sun-moon': 'Sol y Luna',
  'omega-ruby-alpha-sapphire': 'Rubí Omega y Zafiro Alfa',
  'x-y': 'X e Y',
  'black-2-white-2': 'Negro 2 y Blanco 2',
  'black-white': 'Negro y Blanco',
  'heartgold-soulsilver': 'Oro HeartGold y Plata SoulSilver',
  'platinum': 'Platino',
  'diamond-pearl': 'Diamante y Perla',
  'xd': 'XD: Tempestad Oscura',
  'colosseum': 'Colosseum',
  'firered-leafgreen': 'Rojo Fuego y Verde Hoja',
  'emerald': 'Esmeralda',
  'ruby-sapphire': 'Rubí y Zafiro',
  'crystal': 'Cristal',
  'gold-silver': 'Oro y Plata',
  'yellow': 'Amarillo',
  'red-blue': 'Rojo y Azul',
  'red-green-japan': 'Rojo y Verde (Japón)',
  'blue-japan': 'Azul (Japón)',
};

// Posición del juego en la lista, sirve para ordenarlos
// Los que no están en la lista van al final
int posicionJuego(String grupo) {
  final i = _nombresJuegos.keys.toList().indexOf(grupo);
  return i == -1 ? _nombresJuegos.length : i;
}

String nombreJuego(String grupo) =>
    _nombresJuegos[grupo] ?? nombreLegible(grupo);

const _nombresMetodos = {
  'level-up': 'Nivel',
  'machine': 'MT/MO',
  'tutor': 'Tutor',
  'egg': 'Huevo',
};

// Métodos que siempre se ofrecen como filtro (RF-DET-05)
const metodosBase = ['level-up', 'machine', 'tutor', 'egg'];

String nombreMetodo(String metodo) =>
    _nombresMetodos[metodo] ?? nombreLegible(metodo);