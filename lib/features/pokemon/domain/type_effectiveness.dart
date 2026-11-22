/// Tabla de efectividad de tipos
/// La primera clave es el tipo que ataca y la segunda el tipo que defiende
/// Solo se escriben los valores distintos de 1
/// 2 es super efectivo, 0.5 es poco efectivo y 0 es que no le afecta
const Map<String, Map<String, double>> tablaTipos = {
  'normal': {'rock': 0.5, 'ghost': 0, 'steel': 0.5},
  'fire': {'fire': 0.5, 'water': 0.5, 'grass': 2, 'ice': 2, 'bug': 2, 'rock': 0.5, 'dragon': 0.5, 'steel': 2},
  'water': {'fire': 2, 'water': 0.5, 'grass': 0.5, 'ground': 2, 'rock': 2, 'dragon': 0.5},
  'electric': {'water': 2, 'electric': 0.5, 'grass': 0.5, 'ground': 0, 'flying': 2, 'dragon': 0.5},
  'grass': {'fire': 0.5, 'water': 2, 'grass': 0.5, 'poison': 0.5, 'ground': 2, 'flying': 0.5, 'bug': 0.5, 'rock': 2, 'dragon': 0.5, 'steel': 0.5},
  'ice': {'fire': 0.5, 'water': 0.5, 'grass': 2, 'ice': 0.5, 'ground': 2, 'flying': 2, 'dragon': 2, 'steel': 0.5},
  'fighting': {'normal': 2, 'ice': 2, 'poison': 0.5, 'flying': 0.5, 'psychic': 0.5, 'bug': 0.5, 'rock': 2, 'ghost': 0, 'dark': 2, 'steel': 2, 'fairy': 0.5},
  'poison': {'grass': 2, 'poison': 0.5, 'ground': 0.5, 'rock': 0.5, 'ghost': 0.5, 'steel': 0, 'fairy': 2},
  'ground': {'fire': 2, 'electric': 2, 'grass': 0.5, 'poison': 2, 'flying': 0, 'bug': 0.5, 'rock': 2, 'steel': 2},
  'flying': {'electric': 0.5, 'grass': 2, 'fighting': 2, 'bug': 2, 'rock': 0.5, 'steel': 0.5},
  'psychic': {'fighting': 2, 'poison': 2, 'psychic': 0.5, 'dark': 0, 'steel': 0.5},
  'bug': {'fire': 0.5, 'grass': 2, 'fighting': 0.5, 'poison': 0.5, 'flying': 0.5, 'psychic': 2, 'ghost': 0.5, 'dark': 2, 'steel': 0.5, 'fairy': 0.5},
  'rock': {'fire': 2, 'ice': 2, 'fighting': 0.5, 'ground': 0.5, 'flying': 2, 'bug': 2, 'steel': 0.5},
  'ghost': {'normal': 0, 'psychic': 2, 'ghost': 2, 'dark': 0.5},
  'dragon': {'dragon': 2, 'steel': 0.5, 'fairy': 0},
  'dark': {'fighting': 0.5, 'psychic': 2, 'ghost': 2, 'dark': 0.5, 'fairy': 0.5},
  'steel': {'fire': 0.5, 'water': 0.5, 'electric': 0.5, 'ice': 2, 'rock': 2, 'steel': 0.5, 'fairy': 2},
  'fairy': {'fire': 0.5, 'fighting': 2, 'poison': 0.5, 'dragon': 2, 'dark': 2, 'steel': 0.5},
};

/// Calcula cuanto daño recibe un pokemon de cada tipo de ataque
/// Recibe los nombres de sus tipos
/// Devuelve un mapa con el multiplicador de cada tipo de ataque
/// Mayor que 1 es debilidad, entre 0 y 1 es resistencia y 0 es inmunidad
Map<String, double> calcularEfectividad(List<String> tiposDefensor) {
  final resultado = <String, double>{};

  for (final ataque in tablaTipos.keys) {
    var multiplicador = 1.0;
    for (final defensa in tiposDefensor) {
      // si la combinacion no esta en la tabla, vale 1
      multiplicador *= tablaTipos[ataque]![defensa] ?? 1.0;
    }
    resultado[ataque] = multiplicador;
  }

  return resultado;
}