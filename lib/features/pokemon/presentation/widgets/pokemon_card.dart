import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/pokemon_image.dart';
import '../../domain/entities/pokemon.dart';
import 'type_colors.dart';

// Ficha de cada pokemon en el catálogo
// Borde y sombra con el color de su tipo principal, esquinas de escáner en el sprite
class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon, this.alTocar});

  final Pokemon pokemon;
  final VoidCallback? alTocar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final temaTexto = Theme.of(context).textTheme;
    final esquinas = BorderRadius.circular(6);

    final nombre = _capitalizar(pokemon.name);
    final numero = '#${pokemon.nationalDexNumber.toString().padLeft(4, '0')}';
    final nombresTipos = pokemon.types
        .map((t) => _capitalizar(t.name))
        .toList();

    final colorBorde = pokemon.types.isEmpty
        ? Paleta.borde
        : colorBordeTipo(colorDeTipo(pokemon.types.first.name));

    // El lector de pantalla lee toda la ficha en una sola frase
    return Semantics(
      button: alTocar != null,
      label: '$nombre, número $numero, tipos: ${nombresTipos.join(', ')}',
      excludeSemantics: true,
      child: Container(
        decoration: BoxDecoration(
          color: colores.surface,
          borderRadius: esquinas,
          border: Border.all(color: colorBorde, width: 2),
          // Sombra dura sin desenfoque, es barata de dibujar en una lista larga
          boxShadow: [BoxShadow(color: colorBorde, offset: const Offset(4, 4))],
        ),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: esquinas,
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
                      fontWeight: FontWeight.w600,
                      color: colores.onSurfaceVariant,
                    ),
                  ),
                  // El marco ocupa el espacio que sobra, es lo más grande
                  Expanded(
                    child: CustomPaint(
                      painter: _EsquinasEscaner(colorBorde),
                      child: Center(
                        // El sprite tiene un borde transparente grande, por eso se agranda
                        child: Transform.scale(
                          scale: 1.35,
                          child: PokemonImage(
                            url: pokemon.imageUrl,
                            size: 110,
                            filterQuality: FilterQuality.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // El nombre se achica para caber completo, así no se pierde con texto grande (RNF-ACC-04)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      nombre,
                      maxLines: 1,
                      style: temaTexto.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: pokemon.types.map((t) {
                      return _ChipTipo(
                        etiqueta: _capitalizar(t.name),
                        color: colorDeTipo(t.name),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Etiqueta del tipo con el color del tipo de fondo y texto legible encima
class _ChipTipo extends StatelessWidget {
  const _ChipTipo({required this.etiqueta, required this.color});

  final String etiqueta;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        etiqueta,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorTextoSobre(color),
        ),
      ),
    );
  }
}

// Dibuja las cuatro esquinas del marco, dos rayitas por esquina
class _EsquinasEscaner extends CustomPainter {
  const _EsquinasEscaner(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const largo = 14.0;
    // Se achica 1 dp para que el trazo no quede cortado en el borde
    final caja = (Offset.zero & size).deflate(1);

    final ruta = Path()
      ..moveTo(caja.left, caja.top + largo)
      ..lineTo(caja.left, caja.top)
      ..lineTo(caja.left + largo, caja.top)
      ..moveTo(caja.right - largo, caja.top)
      ..lineTo(caja.right, caja.top)
      ..lineTo(caja.right, caja.top + largo)
      ..moveTo(caja.left, caja.bottom - largo)
      ..lineTo(caja.left, caja.bottom)
      ..lineTo(caja.left + largo, caja.bottom)
      ..moveTo(caja.right - largo, caja.bottom)
      ..lineTo(caja.right, caja.bottom)
      ..lineTo(caja.right, caja.bottom - largo);
    canvas.drawPath(ruta, lapiz);
  }

  // Solo se vuelve a dibujar si cambia el color
  @override
  bool shouldRepaint(_EsquinasEscaner anterior) => anterior.color != color;
}

// La API manda los nombres en minúscula
String _capitalizar(String s) {
  return s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}
