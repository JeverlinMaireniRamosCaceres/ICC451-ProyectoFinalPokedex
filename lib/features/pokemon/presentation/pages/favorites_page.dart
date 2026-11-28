import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../domain/entities/pokemon.dart';
import '../widgets/indicador_conexion.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/rejilla_pokemon.dart';

// Pantalla de favoritos, solo dibuja según lo que recibe
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    super.key,
    required this.pokemons,
    required this.hayError,
    required this.alReintentar,
    required this.alAbrirDetalle,
  });

  // null mientras se leen de la base
  final List<Pokemon>? pokemons;
  final bool hayError;
  final VoidCallback alReintentar;
  final ValueChanged<Pokemon> alAbrirDetalle;

  @override
  Widget build(BuildContext context) {
    final lista = pokemons;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoritos',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: const [IndicadorConexion()],
      ),
      body: CustomScrollView(
        slivers: [
          if (hayError)
            SliverFillRemaining(
              hasScrollBody: false,
              child: ErrorState(
                mensaje: 'No se pudieron leer los favoritos',
                alReintentar: alReintentar,
              ),
            )
          else if (lista == null)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Cargando favoritos',
                ),
              ),
            )
          else if (lista.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  mensaje:
                  'Todavía no tienes favoritos. Toca el corazón de un Pokémon para guardarlo aquí.',
                  icono: Icons.favorite_border,
                ),
              )
            else
              RejillaPokemon(
                pokemons: lista,
                alAbrirDetalle: alAbrirDetalle,
                etiquetaHero: etiquetaHeroFavoritos,
              ),
        ],
      ),
    );
  }
}