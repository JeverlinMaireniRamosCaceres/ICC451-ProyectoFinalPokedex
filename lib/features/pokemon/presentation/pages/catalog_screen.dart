import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_providers.dart';
import 'catalog_page.dart';

// Único punto donde el catálogo se conecta con Riverpod
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pide la siguiente página. Si falla, el error queda en consola
    // y el estado error queda guardado en SyncMetadata
    void loadMore() {
      ref.read(pokemonRepositoryProvider).fetchNextPage().catchError((Object e) {
        debugPrint('No se pudo cargar más $e');
      });
    }

    return CatalogPage(
      state: ref.watch(catalogStateProvider),
      onRetry: loadMore,
      onLoadMore: loadMore,
      monitor: ref.watch(connectivityMonitorProvider),
    );
  }

}