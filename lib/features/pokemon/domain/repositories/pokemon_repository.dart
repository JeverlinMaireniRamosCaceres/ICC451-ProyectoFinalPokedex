import '../entities/pokemon.dart';

// Estado de la sincronización del catálogo, lo que la pantalla necesita saber
enum SyncState {
  // Todavía no empezó o hay más páginas pendientes
  idle,
  syncing,
  // Ya se descargo todo el catálogo
  complete,
  error,
}

/// Es la interfaz, digase lo que se puede pedir
/// Es implementado por PokemonRepositoryImpl
abstract class PokemonRepository {
  Stream<List<Pokemon>> watchCatalog();

  // Estado del sync, se actualiza solo cuando cambia
  Stream<SyncState> watchSyncState();

  Future<void> refreshCatalog();

  Future<void> fetchNextPage();
}
