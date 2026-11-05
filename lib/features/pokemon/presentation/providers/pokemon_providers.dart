import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failure.dart';
import '../../data/datasources/local/pokemon_local_datasource.dart';
import '../../data/datasources/remote/pokemon_remote_datasource.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import 'catalog_state.dart';

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

// Se expone el contrato del dominio, no la clase concreta
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(
    local: ref.watch(pokemonLocalDataSourceProvider),
    remote: ref.watch(pokemonRemoteDataSourceProvider),
  );
});

// El Stream que viene de la base local, se actualiza solo
final catalogStreamProvider = StreamProvider<List<Pokemon>>((ref) {
  return ref.watch(pokemonRepositoryProvider).watchCatalog();
});

// Convierte el resultado del Stream en los 4 estados de la pantalla
final catalogStateProvider = Provider<CatalogState>((ref) {
  final async = ref.watch(catalogStreamProvider);

  return switch (async) {
    AsyncData(:final value) =>
    value.isEmpty ? const CatalogEmpty() : CatalogSuccess(value),
    AsyncError(:final error) => CatalogError(
      error is Failure ? error : const UnknownFailure(),
    ),
    _ => const CatalogLoading(),
  };
});
