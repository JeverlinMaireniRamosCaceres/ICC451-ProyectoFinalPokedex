import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_providers.dart';
import '../widgets/pokemon_card.dart';
import 'detail_screen.dart';
import 'favorites_page.dart';

// Lee los favoritos de la base y se los pasa a FavoritesPage
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritos = ref.watch(favoritosStreamProvider);
    // Mantiene vivo el trabajo que completa los detalles de los favoritos
    // La pantalla existe desde que abre la app, porque MainScreen usa un IndexedStack
    ref.watch(sincronizacionFavoritosProvider);

    return FavoritesPage(
      pokemons: favoritos.value,
      hayError: favoritos.hasError,
      // Vuelve a crear el stream, por si falló la lectura
      alReintentar: () => ref.invalidate(favoritosStreamProvider),
      alAbrirDetalle: (pokemon) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DetailScreen(
            pokemon: pokemon,
            // Etiqueta propia, el catálogo ya usa la suya con el mismo Pokemon
            etiquetaHero: etiquetaHeroFavoritos(pokemon.id),
          ),
        ),
      ),
    );
  }
}