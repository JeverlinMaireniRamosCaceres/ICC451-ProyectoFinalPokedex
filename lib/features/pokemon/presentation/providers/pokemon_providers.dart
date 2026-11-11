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
    onSyncingChanged: ref.watch(connectivityMonitorProvider).setSyncing,
  );
});

// Se expone el contrato del dominio, no la clase concreta
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(
    local: ref.watch(pokemonLocalDataSourceProvider),
    syncCoordinator: ref.watch(pokemonSyncCoordinatorProvider),
  );
});

// El Stream que viene de la base local, se actualiza solo
final catalogStreamProvider = StreamProvider<List<Pokemon>>((ref) {
  return ref.watch(pokemonRepositoryProvider).watchCatalog();
});

// El estado del sync, también viene de la base local
final syncStateProvider = StreamProvider<SyncState>((ref) {
  return ref.watch(pokemonRepositoryProvider).watchSyncState();
});

// Convierte el resultado del Stream en los 4 estados de la pantalla
final catalogStateProvider = Provider<CatalogState>((ref) {
  final catalog = ref.watch(catalogStreamProvider);
  // Mientras no llegue el estado se asume que el sync todavía no empezó
  final sync = ref.watch(syncStateProvider).value ?? SyncState.idle;

  return switch (catalog) {
    AsyncData(:final value) when value.isNotEmpty => CatalogSuccess(value),
    // Sin datos, el estado del sync decide qué se le explica al usuario
    AsyncData() => switch (sync) {
      SyncState.idle || SyncState.syncing => const CatalogLoading(),
      SyncState.error => const CatalogError(
        UnknownFailure(
          'No se pudo descargar el catálogo. Revisa tu conexión e intenta de nuevo.',
        ),
      ),
      SyncState.complete => const CatalogEmpty(),
    },
    AsyncError(:final error) => CatalogError(
      error is Failure ? error : const UnknownFailure(),
    ),
    _ => const CatalogLoading(),
  };
});

final connectivityMonitorProvider = Provider<ConnectivityMonitor>((ref) {
  final monitor = ConnectivityMonitor();

  monitor.start();

  ref.onDispose(monitor.dispose);

  return monitor;
});
