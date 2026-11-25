import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Muestra la imagen del pokemon
// La guarda en el telefono para verla sin conexion
// Si falla, prueba con la imagen alternativa y si tampoco esta disponible muestra un icono
class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.url,
    required this.size,
    this.urlAlternativa,
    this.semanticLabel,
    this.filterQuality = FilterQuality.medium,
  });

  final String? url;
  final double size;
  // Imagen de respaldo, por ejemplo el sprite cuando falla el artwork
  final String? urlAlternativa;
  final String? semanticLabel;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    // La imagen se carga en el tamaño en que se muestra, para evitar gastar memoria
    final px = (size * MediaQuery.devicePixelRatioOf(context)).round();

    // Si no hay imagen principal se usa la alternativa como principal
    final principal = url ?? urlAlternativa;
    final respaldo = url == null ? null : urlAlternativa;

    return Semantics(
      label: semanticLabel,
      image: true,
      child: SizedBox(
        width: size,
        height: size,
        child: principal == null
            ? _Fallback(size: size)
            : _cargar(principal, respaldo, px),
      ),
    );
  }

  // Si la imagen falla se vuelve a llamar con el respaldo, que ya no tiene otro detrás
  // así la cadena termina en el icono y no se repite para siempre
  Widget _cargar(String direccion, String? respaldo, int px) {
    return CachedNetworkImage(
      imageUrl: direccion,
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
      // Si no hay internet y la imagen no estaba guardada, se prueba el respaldo
      errorWidget: (_, _, _) =>
      respaldo == null ? _Fallback(size: size) : _cargar(respaldo, null, px),
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