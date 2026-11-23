import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failure.dart';
import '../../data/datasources/local/pokemon_local_datasource.dart';
import '../../data/datasources/remote/pokemon_remote_datasource.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import 'catalog_state.dart';
import '../../../../core/network/connectivity_monitor.dart';
import '../../data/sync/pokemon_sync_coordinator.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/pokemon_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Una sola base para toda la app, se cierra cuando ya nadie la usa
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>((ref) {
  return PokemonLocalDataSource(ref.watch(appDatabaseProvider));
});

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((
  ref,
) {
  return PokemonRemoteDataSource();
});

// Conecta el coordinador con el monitor, para que el indicador
// muestre Sincronizando
final pokemonSyncCoordinatorProvider = Provider<PokemonSyncCoordinator>((ref) {
  return PokemonSyncCoordinator(
    ref.watch(pokemonRemoteDataSourceProvider),
    ref.watch(pokemonLocalDataSourceProvider),
    ref.watch(appDatabaseProvider),
    alCambiarSincronizando: ref.watch(connectivityMonitorProvider).cambiarSincronizando,
  );
});

// Se expone el contrato del dominio, no la clase concreta
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(
    local: ref.watch(pokemonLocalDataSourceProvider),
    coordinadorSincronizacion: ref.watch(pokemonSyncCoordinatorProvider),
  );
});

// Preferencias guardadas en el telefono
// Se cargan en main antes de abrir la app y se pasan con overrideWithValue
// Aqui lanza error para que no se use sin haberlas cargado
final preferenciasProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Las preferencias se cargan en main');
});

// Guarda el texto de busqueda
// Espera 400 ms sin que el usuario escriba antes de buscar (debounce)
// asi no se hace una consulta por cada letra
// Se guarda en las preferencias para conservarla al cerrar la app
class BusquedaNotifier extends Notifier<String> {
  Timer? _espera;

  @override
  String build() {
    ref.onDispose(() => _espera?.cancel());
    // empieza con la busqueda de la ultima vez, o vacia si no hay
    return ref.read(preferenciasProvider).getString('busqueda') ?? '';
  }

  void escribir(String texto) {
    _espera?.cancel();
    _espera = Timer(const Duration(milliseconds: 400), () {
      state = texto.trim().toLowerCase();
      unawaited(ref.read(preferenciasProvider).setString('busqueda', state));
    });
  }
}

final busquedaProvider = NotifierProvider<BusquedaNotifier, String>(
  BusquedaNotifier.new,
);

// Filtros y orden elegidos en el catalogo
// null en tipo o generacion significa que no se filtra por eso
class FiltrosCatalogo {
  const FiltrosCatalogo({
    this.tipo,
    this.generacion,
    this.orden = OrdenCatalogo.numero,
  });

  final String? tipo;
  final int? generacion;
  final OrdenCatalogo orden;
}

// Guarda los filtros, cada cambio crea un FiltrosCatalogo nuevo con el valor cambiado
// y los demas igual, asi Riverpod detecta el cambio y vuelve a consultar
// Se guardan en las preferencias para conservarlos al cerrar la app
class FiltrosNotifier extends Notifier<FiltrosCatalogo> {
  @override
  FiltrosCatalogo build() {
    // empieza con los filtros de la ultima vez
    final preferencias = ref.read(preferenciasProvider);
    final orden = preferencias.getString('orden');
    return FiltrosCatalogo(
      tipo: preferencias.getString('tipo'),
      generacion: preferencias.getInt('generacion'),
      // el orden se guarda como texto, byName lo vuelve a convertir en el enum
      orden: orden == null
          ? OrdenCatalogo.numero
          : OrdenCatalogo.values.byName(orden),
    );
  }

  void cambiarTipo(String? tipo) {
    _guardar(FiltrosCatalogo(
      tipo: tipo,
      generacion: state.generacion,
      orden: state.orden,
    ));
  }

  void cambiarGeneracion(int? generacion) {
    _guardar(FiltrosCatalogo(
      tipo: state.tipo,
      generacion: generacion,
      orden: state.orden,
    ));
  }

  void cambiarOrden(OrdenCatalogo orden) {
    _guardar(FiltrosCatalogo(
      tipo: state.tipo,
      generacion: state.generacion,
      orden: orden,
    ));
  }

  // Cambia el estado y lo guarda en el telefono
  // Si un filtro es null se borra, para que al volver no se aplique
  void _guardar(FiltrosCatalogo filtros) {
    state = filtros;
    final preferencias = ref.read(preferenciasProvider);

    if (filtros.tipo == null) {
      unawaited(preferencias.remove('tipo'));
    } else {
      unawaited(preferencias.setString('tipo', filtros.tipo!));
    }

    if (filtros.generacion == null) {
      unawaited(preferencias.remove('generacion'));
    } else {
      unawaited(preferencias.setInt('generacion', filtros.generacion!));
    }

    unawaited(preferencias.setString('orden', filtros.orden.name));
  }
}

final filtrosProvider = NotifierProvider<FiltrosNotifier, FiltrosCatalogo>(
  FiltrosNotifier.new,
);

// El Stream que viene de la base local, se actualiza solo
final catalogStreamProvider = StreamProvider<List<Pokemon>>((ref) {
  final busqueda = ref.watch(busquedaProvider);
  final filtros = ref.watch(filtrosProvider);
  return ref.watch(pokemonRepositoryProvider).observarCatalogo(
    busqueda: busqueda,
    tipo: filtros.tipo,
    generacion: filtros.generacion,
    orden: filtros.orden,
  );
});

// El estado del sync, también viene de la base local
final syncStateProvider = StreamProvider<SyncState>((ref) {
  return ref.watch(pokemonRepositoryProvider).observarEstadoSincronizacion();
});

// Convierte el resultado del Stream en los 4 estados de la pantalla
final catalogStateProvider = Provider<CatalogState>((ref) {
  final catalogo = ref.watch(catalogStreamProvider);
  // Mientras no llegue el estado se asume que el sync todavía no empezó
  final sincronizacion = ref.watch(syncStateProvider).value ?? SyncState.inactivo;
  final busqueda = ref.watch(busquedaProvider);

  final filtros = ref.watch(filtrosProvider);
  final hayFiltros = busqueda.isNotEmpty ||
      filtros.tipo != null ||
      filtros.generacion != null;

  return switch (catalogo) {
    AsyncData(:final value) when value.isNotEmpty || hayFiltros =>
        CatalogSuccess(value),
    // Sin datos, el estado del sync decide qué se le explica al usuario
    AsyncData() => switch (sincronizacion) {
      SyncState.inactivo || SyncState.sincronizando => const CatalogLoading(),
      SyncState.error => CatalogError(
        ref.read(pokemonRepositoryProvider).ultimoError ?? const UnknownFailure(),
      ),
      SyncState.completo => const CatalogEmpty(),
    },
    AsyncError(:final error) => CatalogError(
      error is Failure ? error : const UnknownFailure(),
    ),
    _ => const CatalogLoading(),
  };
});

final connectivityMonitorProvider = Provider<ConnectivityMonitor>((ref) {
  final monitor = ConnectivityMonitor();

  monitor.iniciar();

  ref.onDispose(monitor.dispose);

  return monitor;
});

// Detalle de un Pokemon por su id
// Muestra lo que ya este guardado en la base y al mismo tiempo pide
// la version de la API, cuando llega se guarda y la pantalla se actualiza sola
final detalleProvider = StreamProvider.family<PokemonDetail?, int>((ref, id) {
  final repositorio = ref.watch(pokemonRepositoryProvider);

  unawaited(
    repositorio.sincronizarDetalle(id).catchError((Object e) {
      debugPrint('No se pudo actualizar el detalle $id $e');
    }),
  );

  return repositorio.observarDetalle(id);
});
