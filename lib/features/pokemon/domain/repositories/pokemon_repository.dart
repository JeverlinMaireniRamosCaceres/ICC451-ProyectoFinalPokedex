import '../entities/pokemon.dart';
import '../../../../core/errors/failure.dart';
import '../entities/pokemon_detail.dart';

// Estado de la sincronización del catálogo, lo que la pantalla necesita saber
enum SyncState {
  // Todavía no empezó o hay más páginas pendientes
  inactivo,
  sincronizando,
  // Ya se descargo todo el catálogo
  completo,
  error,
}

// Criterios para ordenar el catalogo
enum OrdenCatalogo {
  numero,
  nombre,
  // total de estadisticas base, de mayor a menor
  total,
}

/// Es la interfaz, digase lo que se puede pedir
/// Es implementado por PokemonRepositoryImpl
abstract class PokemonRepository {
  Stream<List<Pokemon>> observarCatalogo({
    String busqueda = '',
    String? tipo,
    int? generacion,
    OrdenCatalogo orden = OrdenCatalogo.numero,
  });

  // Estado del sync, se actualiza solo cuando cambia
  Stream<SyncState> observarEstadoSincronizacion();

  Future<void> actualizarCatalogo();

  Future<void> obtenerSiguientePagina();

  // Vuelve a descargar lo guardado y lo sobrescribe
  // es decir, restaura datos alterados
  Future<void> revisarCatalogo();

  // Ultimo error de sincronizacion, null si no ha fallado
  Failure? get ultimoError;

  // Detalle guardado en la base, null si todavia no se ha descargado
  Stream<PokemonDetail?> observarDetalle(int id);

  // Descarga el detalle de la API y lo guarda en la base
  Future<void> sincronizarDetalle(int id);

}
