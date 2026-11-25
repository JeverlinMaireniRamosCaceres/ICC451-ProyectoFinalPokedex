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

  // Descarga la primera pagina
  // Despues revisa todo lo guardado
  // Se usa al iniciar, al volver la conexion y cada 10 minutos
  Future<void> sincronizar(String motivo) async {
    debugPrint('[Sync] Sincronizando por $motivo');
    final repositorio = container.read(pokemonRepositoryProvider);
    try {
      await repositorio.actualizarCatalogo();
      await repositorio.revisarCatalogo();
    } catch (e) {
      debugPrint('No se pudo sincronizar por $motivo $e');
    }
  }

  // Al iniciar, sin bloquear la interfaz
  unawaited(sincronizar('inicio'));

  // Cada 10 minutos, solo si la API esta disponible
  Timer.periodic(const Duration(minutes: 10), (_) {
    final estado = container.read(connectivityMonitorProvider).estadoActual;
    if (estado == ConnectivityStatus.conectado) {
      unawaited(sincronizar('revision periodica'));
    }
  });

  // Online-Preferred
  // Cuando la conexion vuelve, se sincroniza sola sin que el usuario haga nada
  ConnectivityStatus? anterior;
  container.read(connectivityMonitorProvider).flujoEstado.listen((estado) {
    final volvio = estado == ConnectivityStatus.conectado &&
        (anterior == ConnectivityStatus.sinConexion ||
            anterior == ConnectivityStatus.servicioNoDisponible);
    if (volvio) {
      unawaited(sincronizar('reconexion'));
    }

    anterior = estado;
  });

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}