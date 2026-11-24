import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon.dart';
import '../providers/pokemon_providers.dart';
import 'detail_page.dart';

// Lee el detalle guardado y se lo pasa a DetailPage
class DetailScreen extends ConsumerWidget {
  const DetailScreen({
    super.key,
    required this.pokemon,
    required this.etiquetaHero,
  });

  final Pokemon pokemon;
  final String etiquetaHero;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Es null mientras el detalle no se ha descargado
    // La cabecera se dibuja igual con lo que ya hay del catálogo
    final detalle = ref.watch(detalleProvider(pokemon.id)).value;

    return DetailPage(
      pokemon: pokemon,
      detalle: detalle,
      etiquetaHero: etiquetaHero,
    );
  }
}