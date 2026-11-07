import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'features/pokemon/presentation/providers/pokemon_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  // Sincroniza el catálogo desde la API sin bloquear la interfaz
  unawaited(
    container
        .read(pokemonRepositoryProvider)
        .refreshCatalog()
        .catchError((error) {
      debugPrint('Error al sincronizar el catálogo: $error');
    }),
  );

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}