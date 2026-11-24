import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/texto.dart';
import '../../../../core/widgets/pokemon_image.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../widgets/chip_tipo.dart';
import '../widgets/indicador_conexion.dart';
import '../widgets/type_colors.dart';

// Pantalla de detalle, solo dibuja lo que recibe
class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.pokemon,
    required this.detalle,
    required this.etiquetaHero,
  });

  final Pokemon pokemon;
  final PokemonDetail? detalle;
  final String etiquetaHero;

  @override
  Widget build(BuildContext context) {
    // La imagen oficial si existe, si no el sprite (RF-DET-01)
    final imagen = detalle?.artwork ?? pokemon.artworkUrl ?? pokemon.imageUrl;

    return Scaffold(
      appBar: AppBar(actions: const [IndicadorConexion()]),
      // Con slivers, las secciones largas que vienen después se construyen solo cuando se ven
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 20, 16),
              child: _Cabecera(
                pokemon: pokemon,
                imagen: imagen,
                etiquetaHero: etiquetaHero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Número, imagen grande, nombre y tipos, con el borde y la sombra del tipo
class _Cabecera extends StatelessWidget {
  const _Cabecera({
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