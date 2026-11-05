import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Imagen del pokémon con caché en disco y recurso de respaldo
class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.url,
    required this.size,
    this.semanticLabel,
    this.filterQuality = FilterQuality.medium,
  });

  final String? url;
  final double size;
  final String? semanticLabel;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    // Se decodifica al tamaño real en pixeles, no a la resolución completa
    final px = (size * MediaQuery.devicePixelRatioOf(context)).round();

    return Semantics(
      label: semanticLabel,
      image: true,
      child: SizedBox(
        width: size,
        height: size,
        child: url == null
            ? _Fallback(size: size)
            : CachedNetworkImage(
                imageUrl: url!,
                memCacheWidth: px,
                memCacheHeight: px,
                fit: BoxFit.contain,
          filterQuality: filterQuality,
                // Mientras descarga
                placeholder: (_, _) => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                // Sin red y sin imagen guardada, no se rompe nada
                errorWidget: (_, _, _) => _Fallback(size: size),
              ),
      ),
    );
  }
}

// Recurso de respaldo cuando la imagen no está disponible
class _Fallback extends StatelessWidget {
  const _Fallback({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.catching_pokemon,
      size: size * 0.6,
      color: Theme.of(context).colorScheme.outline,
    );
  }
}
