import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_providers.dart';
import 'catalog_page.dart';
import '../../../../core/errors/failure.dart';

// Es el unico punto donde el catalogo se conecta con Riverpod
// Lee el estado y las acciones de los providers y se los pasa a CatalogPage, que se encarga de mostrarlo
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pide la pagina que sigue
    // Si falla, muestra abajo el mensaje del error
    // Los Pokemon que ya estan en la base se siguen viendo
    void cargarMas() {
      ref.read(pokemonRepositoryProvider).obtenerSiguientePagina().catchError((Object e) {
        debugPrint('No se pudo cargar más $e');
        if (!context.mounted) return;
        final mensaje = e is Failure ? e.mensaje : 'No se pudo cargar más';
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(mensaje)));
      });
    }

    final filtros = ref.watch(filtrosProvider);
    final cambiarFiltros = ref.read(filtrosProvider.notifier);

    return CatalogPage(
      // hace que la pantalla se redibuje cuando cambia el estado del catalogo
      estado: ref.watch(catalogStateProvider),
      alReintentar: cargarMas,
      alCargarMas: cargarMas,
      monitor: ref.watch(connectivityMonitorProvider),
      alBuscar: ref.read(busquedaProvider.notifier).escribir,
      tipo: filtros.tipo,
      generacion: filtros.generacion,
      orden: filtros.orden,
      alCambiarTipo: cambiarFiltros.cambiarTipo,
      alCambiarGeneracion: cambiarFiltros.cambiarGeneracion,
      alCambiarOrden: cambiarFiltros.cambiarOrden,
      busqueda: ref.read(busquedaProvider),
    );
  }

}