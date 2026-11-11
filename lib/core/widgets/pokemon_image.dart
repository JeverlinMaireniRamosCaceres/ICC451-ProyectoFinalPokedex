import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Muestra la imagen del pokemon
// La guarda en el telefono para verla sin conexion
// si no esta disponible muestra un icono
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
    // La imagen se carga en el tamaño en que se muestra, para evitar gastar memoria
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
                // Si no hay internet y la imagen no estaba guardada, se muestra el icono
                errorWidget: (_, _, _) => _Fallback(size: size),
              ),
      ),
    );
  }
}

// Icono que se muestra cuando no hay imagen
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
