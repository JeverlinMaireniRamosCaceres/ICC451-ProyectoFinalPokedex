import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_stat.dart';
import '../widgets/detalle/cabecera_detalle.dart';
import '../widgets/detalle/panel_datos.dart';
import '../widgets/detalle/panel_estadisticas.dart';
import '../widgets/detalle/panel_evolucion.dart';
import '../widgets/detalle/panel_habilidades.dart';
import '../widgets/detalle/panel_matchups.dart';
import '../widgets/indicador_conexion.dart';

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
    // Las estadísticas ya vienen con el catálogo, así se ven al instante y sin conexión
    final estadisticas = pokemon.stats.isNotEmpty
        ? pokemon.stats
        : (detalle?.estadisticas ?? const <PokemonStat>[]);

    return Scaffold(
      appBar: AppBar(actions: const [IndicadorConexion()]),
      // Con slivers, las secciones largas que vienen después se construyen solo cuando se ven
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 20, 16),
              child: CabeceraDetalle(
                pokemon: pokemon,
                imagen: imagen,
                etiquetaHero: etiquetaHero,
              ),
            ),
          ),
          _SeccionesDetalle(
            pokemon: pokemon,
            detalle: detalle,
            estadisticas: estadisticas,
          ),
        ],
      ),
    );
  }
}

// Las secciones del detalle, una por pestaña
enum _Seccion {
  info('Info'),
  combate('Combate'),
  evolucion('Evolución');

  const _Seccion(this.etiqueta);

  final String etiqueta;
}

// Pestañas y contenido de la sección elegida
// La pestaña elegida solo importa a esta pantalla, por eso no necesita provider
class _SeccionesDetalle extends StatefulWidget {
  const _SeccionesDetalle({
    required this.pokemon,
    required this.detalle,
    required this.estadisticas,
  });

  final Pokemon pokemon;
  final PokemonDetail? detalle;
  final List<PokemonStat> estadisticas;

  @override
  State<_SeccionesDetalle> createState() => _SeccionesDetalleState();
}

class _SeccionesDetalleState extends State<_SeccionesDetalle> {
  _Seccion _seccion = _Seccion.info;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            // Wrap pasa las pestañas a otra línea si no caben con texto grande
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final s in _Seccion.values)
                  ChoiceChip(
                    label: Text(s.etiqueta),
                    selected: _seccion == s,
                    onSelected: (_) => setState(() => _seccion = s),
                    showCheckmark: false,
                    selectedColor: Paleta.rosa,
                    backgroundColor: Paleta.superficie,
                    side: const BorderSide(color: Paleta.borde, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _seccion == s ? Paleta.tinta : Paleta.texto,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList.list(children: _contenido()),
        ),
      ],
    );
  }

  List<Widget> _contenido() {
    final detalle = widget.detalle;

    return switch (_seccion) {
      _Seccion.info => [
        PanelEstadisticas(estadisticas: widget.estadisticas),
        const SizedBox(height: 16),
        PanelHabilidades(detalle: detalle),
        const SizedBox(height: 16),
        PanelDatos(detalle: detalle),
      ],
      _Seccion.combate => [
        PanelMatchups(
          tipos: widget.pokemon.types.map((t) => t.name).toList(),
        ),
      ],
      _Seccion.evolucion => [PanelEvolucion(detalle: detalle)],
    };
  }
}