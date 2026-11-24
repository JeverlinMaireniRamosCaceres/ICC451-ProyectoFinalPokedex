import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../../../core/widgets/pokemon_image.dart';
import '../../../domain/entities/pokemon.dart';
import '../chip_tipo.dart';
import '../type_colors.dart';

// Número, imagen grande, nombre y tipos, con el borde y la sombra del tipo
class CabeceraDetalle extends StatelessWidget {
  const CabeceraDetalle({
    super.key,
    required this.pokemon,
    required this.imagen,
    required this.etiquetaHero,
  });

  final Pokemon pokemon;
  final String? imagen;
  final String etiquetaHero;

  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    final nombre = capitalizar(pokemon.name);
    final numero = '#${pokemon.nationalDexNumber.toString().padLeft(4, '0')}';
    final colorBorde = pokemon.types.isEmpty
        ? Paleta.borde
        : colorBordeTipo(colorDeTipo(pokemon.types.first.name));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Paleta.superficie,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: colorBorde, width: 2),
        boxShadow: [BoxShadow(color: colorBorde, offset: const Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            numero,
            style: temaTexto.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Paleta.textoSecundario,
            ),
          ),
          Center(
            // Misma etiqueta que la tarjeta, así la imagen vuela del catálogo al detalle
            child: Hero(
              tag: etiquetaHero,
              child: PokemonImage(
                url: imagen,
                size: 240,
                semanticLabel: nombre,
              ),
            ),
          ),
          // El nombre se achica para caber completo con texto grande (RNF-ACC-04)
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Semantics(
              header: true,
              child: Text(
                nombre,
                maxLines: 1,
                style: temaTexto.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: pokemon.types.map((t) {
              return ChipTipo(
                etiqueta: capitalizar(t.name),
                color: colorDeTipo(t.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}