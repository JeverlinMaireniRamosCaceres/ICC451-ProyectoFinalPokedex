import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_card.dart';

// Rejilla de tarjetas, la usan el catálogo y los favoritos para verse igual
// Es un sliver, así va dentro del CustomScrollView de cada pantalla
class RejillaPokemon extends StatelessWidget {
  const RejillaPokemon({
    super.key,
    required this.pokemons,
    required this.alAbrirDetalle,
    this.etiquetaHero = etiquetaHeroCatalogo,
  });

  final List<Pokemon> pokemons;
  final ValueChanged<Pokemon> alAbrirDetalle;
  // Cada pantalla usa su propio prefijo para que los Hero no se repitan
  final String Function(int id) etiquetaHero;

  @override
  Widget build(BuildContext context) {
    // La altura crece con el texto del sistema para que no se corte
    final escala = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 2.0);

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
      // Se agregan columnas solas en pantallas anchas
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 196 + 90 * (escala - 1),
        ),
        // Solo se construyen las tarjetas visibles
        delegate: SliverChildBuilderDelegate((_, i) {
          final pokemon = pokemons[i];
          return PokemonCard(
            pokemon: pokemon,
            alTocar: () => alAbrirDetalle(pokemon),
            etiquetaHero: etiquetaHero(pokemon.id),
          );
        }, childCount: pokemons.length),
      ),
    );
  }
}