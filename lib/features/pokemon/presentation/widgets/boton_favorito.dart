import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/pokemon_providers.dart';

// Corazón para marcar o quitar un favorito, se actualiza solo al cambiar la base
class BotonFavorito extends ConsumerWidget {
  const BotonFavorito({
    super.key,
    required this.pokemonId,
    required this.nombre,
    this.tamano = 28,
  });

  final int pokemonId;
  // Para el texto que lee el lector de pantalla
  final String nombre;
  final double tamano;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // select: este botón solo se reconstruye cuando cambia su propio favorito
    final esFavorito = ref.watch(
      idsFavoritosProvider.select((ids) => ids.value?.contains(pokemonId) ?? false),
    );
    // Sin animaciones si el teléfono las tiene desactivadas
    final sinAnimaciones = MediaQuery.disableAnimationsOf(context);

    return IconButton(
      tooltip: esFavorito
          ? 'Quitar $nombre de favoritos'
          : 'Agregar $nombre a favoritos',
      onPressed: () =>
          ref.read(pokemonRepositoryProvider).alternarFavorito(pokemonId),
      icon: AnimatedSwitcher(
        duration: sinAnimaciones
            ? Duration.zero
            : const Duration(milliseconds: 350),
        switchInCurve: Curves.easeOutBack,
        transitionBuilder: (hijo, animacion) =>
            ScaleTransition(scale: animacion, child: hijo),
        // La key distingue el corazón lleno del vacío para que el switcher los anime
        child: Icon(
          esFavorito ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(esFavorito),
          size: tamano,
          color: esFavorito ? Paleta.rosa : Paleta.texto,
        ),
      ),
    );
  }
}