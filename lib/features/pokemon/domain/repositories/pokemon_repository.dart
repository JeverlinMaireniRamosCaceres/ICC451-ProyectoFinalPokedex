import '../entities/pokemon.dart';
import '../../../../core/errors/failure.dart';

// Estado de la sincronización del catálogo, lo que la pantalla necesita saber
enum SyncState {
  // Todavía no empezó o hay más páginas pendientes
  inactivo,
  sincronizando,
  // Ya se descargo todo el catálogo
  completo,
  error,
}

/// Es la interfaz, digase lo que se puede pedir
/// Es implementado por PokemonRepositoryImpl
abstract class PokemonRepository {
  Stream<List<Pokemon>> observarCatalogo();

  // Estado del sync, se actualiza solo cuando cambia
  Stream<SyncState> observarEstadoSincronizacion();

  Future<void> actualizarCatalogo();

  Future<void> obtenerSiguientePagina();

  // Ultimo error de sincronizacion, null si no ha fallado
  Failure? get ultimoError;
}
