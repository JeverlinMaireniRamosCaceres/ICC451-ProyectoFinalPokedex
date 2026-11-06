import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_providers.dart';
import 'catalog_page.dart';

// Único punto donde el catálogo se conecta con Riverpod
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CatalogPage(
      state: ref.watch(catalogStateProvider),
      onRetry: () {},
      onLoadMore: () {},
      monitor: ref.watch(connectivityMonitorProvider),
    );
  }
}