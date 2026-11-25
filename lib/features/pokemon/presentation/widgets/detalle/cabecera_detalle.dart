import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../../../core/widgets/pokemon_image.dart';
import '../../../domain/entities/pokemon.dart';
import '../chip_tipo.dart';
import '../type_colors.dart';
import 'chip_opcion.dart';

// Número, imagen grande, nombre y tipos, con el borde y la sombra del tipo
class CabeceraDetalle extends StatelessWidget {
  const CabeceraDetalle({
    super.key,
    required this.pokemon,
    required this.imagen,
    this.imagenAlternativa,
    required this.etiquetaHero,
    this.esShiny = false,
    this.alCambiarShiny,
    this.reintentoImagen = 0

  });

  final Pokemon pokemon;
  final String? imagen;
  // Se muestra si la imagen principal no se puede cargar, por ejemplo el sprite
  final String? imagenAlternativa;
  final String etiquetaHero;
  final bool esShiny;
  // null cuando no hay imagen shiny, así no se muestra el alternador
  final ValueChanged<bool>? alCambiarShiny;
  // Cambia cuando regresa la conexión, así la imagen vuelve a intentar descargarse
  final int reintentoImagen;


  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    final nombre = capitalizar(pokemon.name);
    final numero = '#${pokemon.nationalDexNumber.toString().padLeft(4, '0')}';
    final colorBorde = pokemon.types.isEmpty
        ? Paleta.borde
        : colorBordeTipo(colorDeTipo(pokemon.types.first.name));

    final cambiarShiny = alCambiarShiny;
    // Sin animaciones si el teléfono las tiene desactivadas
    final sinAnimaciones = MediaQuery.disableAnimationsOf(context);

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
              child: AnimatedSwitcher(
                duration: sinAnimaciones
                    ? Duration.zero
                    : const Duration(milliseconds: 250),
                // La key hace que el switcher note que cambió la imagen
                child: KeyedSubtree(
                  key: ValueKey(imagen),
                  child: PokemonImage(
                    key: ValueKey(reintentoImagen),
                    url: imagen,
                    urlAlternativa: imagenAlternativa,
                    size: 240,
                    semanticLabel: esShiny ? '$nombre shiny' : nombre,
                  ),
                ),
              ),
            ),
          ),
          if (cambiarShiny != null) ...[
            const SizedBox(height: 8),
            // Wrap pasa los chips a otra línea con texto grande (RNF-ACC-04)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: [
                ChipOpcion(
                  etiqueta: 'Normal',
                  elegido: !esShiny,
                  alElegir: () => cambiarShiny(false),
                ),
                ChipOpcion(
                  etiqueta: 'Shiny',
                  elegido: esShiny,
                  alElegir: () => cambiarShiny(true),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
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