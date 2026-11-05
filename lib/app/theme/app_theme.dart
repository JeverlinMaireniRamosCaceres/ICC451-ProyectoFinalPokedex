import 'package:flutter/material.dart';

// Tema de la app, Material 3 con el azul clásico de la Pokédex
ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF3B4CCA));

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
  );
}