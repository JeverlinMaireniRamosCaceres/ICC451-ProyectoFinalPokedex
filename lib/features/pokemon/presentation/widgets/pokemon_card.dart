import 'package:flutter/material.dart';

import '../../../../core/widgets/pokemon_image.dart';
import '../../domain/entities/pokemon.dart';
import 'type_colors.dart';

// Tarjeta de cada pokemon en el catalogo
// el fondo usa el color de su tipo principal
class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon, this.onTap});

  final Pokemon pokemon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final name = _capitalize(pokemon.name);
    final number = '#${pokemon.nationalDexNumber.toString().padLeft(4, '0')}';
    final typeNames = pokemon.types.map((t) => _capitalize(t.name)).toList();

    // El color del tipo se pone claro para que el texto se lea bien
    final mainColor = pokemon.types.isEmpty
        ? colors.outline
        : typeColor(pokemon.types.first.name);
    final background = Color.alphaBlend(
      mainColor.withValues(alpha: 0.2),
      colors.surface,
    );

    // El lector de pantalla lee toda la tarjeta en una sola frase
    return Semantics(
      button: onTap != null,
      label: '$name, número $number, tipos: ${typeNames.join(', ')}',
      excludeSemantics: true,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurfaceVariant,
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
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: typeNames.indexed.map((e) {
                    return _TypeChip(
                      label: e.$2,
                      color: typeColor(pokemon.types[e.$1].name),
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
  const _TypeChip({required this.label, required this.color});

  final String label;
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
            label,
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
String _capitalize(String s) {
  return s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}