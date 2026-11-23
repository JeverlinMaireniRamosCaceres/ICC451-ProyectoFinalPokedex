import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

// Color de cada tipo, la API manda los nombres en minúscula
const _coloresTipo = <String, Color>{
  'normal': Color(0xFFA8A77A),
  'fire': Color(0xFFEE8130),
  'water': Color(0xFF6390F0),
  'electric': Color(0xFFF7D02C),
  'grass': Color(0xFF7AC74C),
  'ice': Color(0xFF96D9D6),
  'fighting': Color(0xFFC22E28),
  'poison': Color(0xFFA33EA1),
  'ground': Color(0xFFE2BF65),
  'flying': Color(0xFFA98FF3),
  'psychic': Color(0xFFF95587),
  'bug': Color(0xFFA6B91A),
  'rock': Color(0xFFB6A136),
  'ghost': Color(0xFF735797),
  'dragon': Color(0xFF6F35FC),
  'dark': Color(0xFF705746),
  'steel': Color(0xFFB7B7CE),
  'fairy': Color(0xFFD685AD),
};

// Si llega un tipo desconocido no se rompe, usa un gris claro
Color colorDeTipo(String nombre) {
  return _coloresTipo[nombre] ?? const Color(0xFFB0BEC5);
}

// Texto del chip: tinta oscura sobre los colores claros y blanco sobre los oscuros
// Con la luminancia se separan bien los dos grupos y todos quedan sobre 5:1 (RNF-ACC-02)
Color colorTextoSobre(Color fondo) {
  return fondo.computeLuminance() > 0.2 ? Paleta.tinta : Paleta.texto;
}

// Los tipos oscuros se pierden como borde sobre la superficie oscura
// Se mezclan con blanco para que se vean, los demás quedan igual
Color colorBordeTipo(Color color) {
  if (color.computeLuminance() >= 0.2) return color;
  return Color.lerp(color, Colors.white, 0.35)!;
}
