import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'dev_seed.dart';
import 'features/pokemon/presentation/providers/pokemon_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  // TEMPORAL: siembra datos de prueba, sin await para no bloquear la interfaz (OF-03)
  unawaited(
    sembrarDatosDePrueba(container.read(pokemonLocalDataSourceProvider)),
  );

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}