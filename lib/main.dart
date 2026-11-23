import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'features/pokemon/presentation/providers/pokemon_providers.dart';
import 'core/network/connectivity_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {

  // Prepara Flutter antes de usar la base de datos y los otros paquetes
  WidgetsFlutterBinding.ensureInitialized();

  // Se cargan las preferencias guardadas antes de abrir la app
  // para que el catalogo empiece con la busqueda y los filtros de la ultima vez
  final preferencias = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [preferenciasProvider.overrideWithValue(preferencias)],
  );

  // Sincroniza el catálogo desde la API sin bloquear la interfaz
  unawaited(
    container
        .read(pokemonRepositoryProvider)
        .actualizarCatalogo()
        .catchError((error) {
      debugPrint('Error al sincronizar el catálogo: $error');
    }),
  );

  // Online-Preferred
  // Cuando la conexion vuelve, se sincroniza sola sin que el usuario haga nada
  ConnectivityStatus? anterior;
  container.read(connectivityMonitorProvider).flujoEstado.listen((estado) {
    final volvio = estado == ConnectivityStatus.conectado &&
        (anterior == ConnectivityStatus.sinConexion ||
            anterior == ConnectivityStatus.servicioNoDisponible);
    if (volvio) {
      debugPrint('[Sync] Volvió la conexión, sincronizando');
      container
          .read(pokemonRepositoryProvider)
          .actualizarCatalogo()
          .catchError((Object e) {
        debugPrint('No se pudo sincronizar al volver la conexión $e');
      });
    }
    anterior = estado;
  });

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}