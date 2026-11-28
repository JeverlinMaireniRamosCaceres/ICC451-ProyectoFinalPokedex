import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/texto.dart';
import '../../../../core/widgets/pokemon_image.dart';
import '../../domain/entities/pokemon.dart';
import 'chip_tipo.dart';
import 'type_colors.dart';
import 'boton_favorito.dart';

// Etiqueta de la animación Hero, lleva el prefijo del catálogo para que no choque con la de favoritos
String etiquetaHeroCatalogo(int id) => 'catalogo-$id';

// Etiqueta del Hero para las tarjetas de la pantalla de favoritos
String etiquetaHeroFavoritos(int id) => 'favoritos-$id';

// Ficha de cada pokemon en el catálogo
// Borde y sombra con el color de su tipo principal, esquinas de escáner en el sprite
class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
    this.alTocar,
    this.etiquetaHero,
  });

  final Pokemon pokemon;
  final VoidCallback? alTocar;
  // Si no se da, usa la del catálogo, la pantalla de favoritos pasa la suya
  final String? etiquetaHero;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final temaTexto = Theme.of(context).textTheme;
    final esquinas = BorderRadius.circular(6);

    final nombre = capitalizar(pokemon.name);
    final numero = '#${pokemon.nationalDexNumber.toString().padLeft(4, '0')}';
    final nombresTipos = pokemon.types
        .map((t) => capitalizar(t.name))
        .toList();

    final colorBorde = pokemon.types.isEmpty
        ? Paleta.borde
        : colorBordeTipo(colorDeTipo(pokemon.types.first.name));

    // Dos tarjetas con el mismo Pokemon no pueden compartir etiqueta Hero
    final etiqueta = etiquetaHero ?? etiquetaHeroCatalogo(pokemon.id);

    // El corazón va fuera de la ficha para que el lector de pantalla lo pueda alcanzar
    // y para que tocarlo no abra el detalle
    // Clip.none evita que el Stack recorte la sombra dura que sobresale de la tarjeta
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        // El lector de pantalla lee toda la ficha en una sola frase
        Semantics(
          button: alTocar != null,
          label: '$nombre, número $numero, tipos: ${nombresTipos.join(', ')}',
          excludeSemantics: true,
          child: Container(
            decoration: BoxDecoration(
              color: colores.surface,
              borderRadius: esquinas,
              border: Border.all(color: colorBorde, width: 2),
              // Sombra dura sin desenfoque, es barata de dibujar en una lista larga
              boxShadow: [
                BoxShadow(color: colorBorde, offset: const Offset(4, 4)),
              ],
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
                              // La imagen vuela hacia el detalle con esta etiqueta
                              child: Hero(
                                tag: etiqueta,
                                child: PokemonImage(
                                  url: pokemon.imageUrl,
                                  size: 110,
                                  filterQuality: FilterQuality.none,
                                ),
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
                          return ChipTipo(
                            etiqueta: capitalizar(t.name),
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
        ),
        Positioned(
          top: 0,
          right: 0,
          child: BotonFavorito(
            pokemonId: pokemon.id,
            nombre: nombre,
            tamano: 22,
          ),
        ),
      ],
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