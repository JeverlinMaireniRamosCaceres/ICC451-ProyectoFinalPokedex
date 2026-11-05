import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../domain/entities/pokemon.dart';
import '../providers/catalog_state.dart';
import '../widgets/pokemon_card.dart';

// Pantalla del catálogo, solo dibuja según el estado que recibe (RF-CAT-04)
class CatalogPage extends StatelessWidget {
  const CatalogPage({
    super.key,
    required this.state,
    required this.onRetry,
    required this.onLoadMore,
  });

  final CatalogState state;
  final VoidCallback onRetry;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Se avisa cuando el usuario se acerca al final, solo si hay lista
      body: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (state is CatalogSuccess &&
              n.metrics.pixels >= n.metrics.maxScrollExtent - 300) {
            onLoadMore();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar.large(
              title: Text(
                'Pokédex',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            // El switch es exhaustivo porque CatalogState es sealed
            switch (state) {
              CatalogLoading() => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Cargando catálogo',
                  ),
                ),
              ),
              CatalogEmpty() => SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  message:
                  'Todavía no hay Pokémon guardados. Conéctate a internet para descargar el catálogo.',
                  actionLabel: 'Actualizar',
                  onAction: onRetry,
                ),
              ),
              CatalogError(:final failure) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(message: failure.message, onRetry: onRetry),
              ),
              CatalogSuccess(:final pokemons) => _PokemonGrid(
                pokemons: pokemons,
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _PokemonGrid extends StatelessWidget {
  const _PokemonGrid({required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    // La altura crece con el texto del sistema para que no se corte (RNF-ACC-04)
    final scale = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 2.0);

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
      // Se agregan columnas solas en pantallas anchas (RF-CAT-06)
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 196 + 90 * (scale - 1),
        ),
        // Solo se construyen las tarjetas visibles (RNF-REN-01)
        delegate: SliverChildBuilderDelegate(
              (_, i) => PokemonCard(pokemon: pokemons[i]),
          childCount: pokemons.length,
        ),
      ),
    );
  }
}