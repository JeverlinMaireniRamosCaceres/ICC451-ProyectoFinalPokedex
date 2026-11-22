import 'package:flutter/material.dart';

import '../../../../core/widgets/pokemon_image.dart';
import '../../domain/entities/pokemon.dart';
import 'type_colors.dart';

// Tarjeta de cada pokemon en el catalogo
// el fondo usa el color de su tipo principal
class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon, this.alTocar});

  final Pokemon pokemon;
  final VoidCallback? alTocar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final temaTexto = Theme.of(context).textTheme;

    final nombre = _capitalizar(pokemon.name);
    final numero = '#${pokemon.nationalDexNumber.toString().padLeft(4, '0')}';
    final nombresTipos = pokemon.types.map((t) => _capitalizar(t.name)).toList();

    // El color del tipo se pone claro para que el texto se lea bien
    final colorPrincipal = pokemon.types.isEmpty
        ? colores.outline
        : colorDeTipo(pokemon.types.first.name);
    final fondo = Color.alphaBlend(
      colorPrincipal.withValues(alpha: 0.2),
      colores.surface,
    );

    // El lector de pantalla lee toda la tarjeta en una sola frase
    return Semantics(
      button: alTocar != null,
      label: '$nombre, número $numero, tipos: ${nombresTipos.join(', ')}',
      excludeSemantics: true,
      child: Material(
        color: fondo,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: alTocar,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  numero,
                  style: temaTexto.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colores.onSurfaceVariant,
                  ),
                ),
                // La imagen ocupa el espacio que sobra, es lo más grande
                Expanded(
                  child: Center(
                    // El sprite tiene un borde transparente grande, por eso se agranda
                    child: Transform.scale(
                      scale: 1.35,
                      child: PokemonImage(url: pokemon.imageUrl, size: 110,  filterQuality: FilterQuality.none),
                    ),
                  ),
                ),
                Text(
                  nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: temaTexto.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: nombresTipos.indexed.map((e) {
                    return _TypeChip(
                      etiqueta: e.$2,
                      color: colorDeTipo(pokemon.types[e.$1].name),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Etiqueta del tipo con texto y un punto de color
class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.etiqueta, required this.color});

  final String etiqueta;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            etiqueta,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// La API manda los nombres en minúscula
String _capitalizar(String s) {
  return s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}