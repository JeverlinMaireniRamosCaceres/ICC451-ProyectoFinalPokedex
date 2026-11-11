import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_providers.dart';
import 'catalog_page.dart';

// Es el unico punto donde el catologo se conecta con Riverpod
// Lee el estado y las acciones de los providers y se los pasa a CatalogPage, que se encarga de mostrarlo
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pide la pagina que sigue
    // Si falla, el error queda en consola
    // y el estado error queda guardado en SyncMetadata
    void loadMore() {
      ref.read(pokemonRepositoryProvider).fetchNextPage().catchError((Object e) {
        debugPrint('No se pudo cargar más $e');
      });
    }

    return CatalogPage(
      // hace que la pantalla se redibuje cuando cambia el estado del catalogo
      state: ref.watch(catalogStateProvider),
      onRetry: loadMore,
      onLoadMore: loadMore,
      monitor: ref.watch(connectivityMonitorProvider),
    );
  }

}