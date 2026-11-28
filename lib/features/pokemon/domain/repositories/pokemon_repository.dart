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

  // Ultimo error de sincronizacion, null si no ha fallado
  Failure? get ultimoError;

  // Detalle guardado en la base, null si todavia no se ha descargado
  Stream<PokemonDetail?> observarDetalle(int id);

  // Descarga el detalle de la API y lo guarda en la base
  Future<void> sincronizarDetalle(int id);

  // Ids de los Pokemon favoritos, para saber qué corazones van marcados
  Stream<Set<int>> observarIdsFavoritos();

  // Pokemon favoritos, del más reciente al más antiguo
  Stream<List<Pokemon>> observarFavoritos();

  // Marca el favorito si no lo era y lo quita si lo era
  Future<void> alternarFavorito(int pokemonId);

  // Descarga el detalle de los favoritos que todavía no lo tienen guardado
  // Así están completos sin conexión, no hace nada si ya los tienen todos
  Future<void> sincronizarDetallesFavoritos();

}
