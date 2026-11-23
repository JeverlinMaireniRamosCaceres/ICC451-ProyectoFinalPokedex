import 'package:flutter/material.dart';

// Todos los colores de la app en un solo lugar, para cambiarlos fácil
abstract final class Paleta {
  static const fondo = Color(0xFF1C1730);
  static const superficie = Color(0xFF2A2342);
  static const texto = Color(0xFFFBF3FF);
  static const textoSecundario = Color(0xFFC9BEE3);
  // Acento rosa sakura, para botones, pestaña activa y detalles
  static const rosa = Color(0xFFFF7BA5);
  // Texto sobre botones y chips claros, es el mismo tono del fondo
  static const tinta = fondo;
  static const borde = Color(0xFF9A8FBD);
  static const error = Color(0xFFFF8A80);
  // Rosa claro de los pétalos, solo decoración
  static const petalo = Color(0xFFFFC2D6);
  static const petaloOscuro = Color(0xFFFF9DBB);
}

// Tema oscuro de la app, fondo ciruela con acento rosa sakura
ThemeData construirTema() {
  // Esquinas casi rectas en botones, sin forma de pastilla
  final forma = RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));

  return ThemeData(
    useMaterial3: true,
    fontFamily: 'ChakraPetch',
    scaffoldBackgroundColor: Paleta.fondo,
    colorScheme: const ColorScheme.dark(
      primary: Paleta.rosa,
      onPrimary: Paleta.tinta,
      secondary: Paleta.rosa,
      onSecondary: Paleta.tinta,
      surface: Paleta.superficie,
      onSurface: Paleta.texto,
      onSurfaceVariant: Paleta.textoSecundario,
      outline: Paleta.borde,
      error: Paleta.error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Paleta.fondo,
      foregroundColor: Paleta.texto,
      // Sin tinte de color cuando la lista pasa por debajo
      surfaceTintColor: Colors.transparent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Paleta.rosa,
        foregroundColor: Paleta.tinta,
        // Área táctil mínima de 48 dp (RNF-ACC-03)
        minimumSize: const Size(48, 48),
        shape: forma,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Paleta.rosa,
        side: const BorderSide(color: Paleta.rosa, width: 2),
        minimumSize: const Size(48, 48),
        shape: forma,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Paleta.superficie,
      indicatorColor: Paleta.rosa,
      // Esquinas casi rectas, igual que el resto
      indicatorShape: forma,
      iconTheme: WidgetStateProperty.resolveWith((estados) {
        final elegido = estados.contains(WidgetState.selected);
        return IconThemeData(
          color: elegido ? Paleta.tinta : Paleta.textoSecundario,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((estados) {
        final elegido = estados.contains(WidgetState.selected);
        return TextStyle(
          fontSize: 12,
          fontWeight: elegido ? FontWeight.w700 : FontWeight.w400,
          color: Paleta.texto,
        );
      }),
    ),
  );
}
