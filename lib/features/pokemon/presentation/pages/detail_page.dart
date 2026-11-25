import 'package:flutter/material.dart';

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
import '../widgets/detalle/chip_opcion.dart';
import '../widgets/detalle/panel_detalle.dart';
import '../widgets/detalle/panel_movimientos.dart';
import '../widgets/detalle/selector_formas.dart';

// Pantalla de detalle, solo dibuja lo que recibe
class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.pokemon,
    required this.detalle,
    required this.etiquetaHero,
    required this.formas,
    required this.nombreBase,
    required this.idForma,
    required this.formaPendiente,
    required this.alElegirForma,
  });

  final Pokemon pokemon;
  final PokemonDetail? detalle;
  final String etiquetaHero;
  final List<PokemonForm> formas;
  final String nombreBase;
  final int idForma;
  // true si se eligió una forma que todavía no se ha descargado
  final bool formaPendiente;
  final ValueChanged<int> alElegirForma;

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
          // Siempre está en la lista, así las secciones de abajo no cambian de posición
          SliverToBoxAdapter(
            child: SelectorFormas(
              formas: formas,
              nombreBase: nombreBase,
              idElegido: idForma,
              alElegir: alElegirForma,
            ),
          ),
          _SeccionesDetalle(
            pokemon: pokemon,
            detalle: detalle,
            estadisticas: estadisticas,
            formaPendiente: formaPendiente,
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
    required this.formaPendiente,
  });

  final Pokemon pokemon;
  final PokemonDetail? detalle;
  final List<PokemonStat> estadisticas;
  final bool formaPendiente;

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
                  ChipOpcion(
                    etiqueta: s.etiqueta,
                    elegido: _seccion == s,
                    alElegir: () => setState(() => _seccion = s),
                  ),
              ],
            ),
          ),
        ),
        ..._contenido(),
      ],
    );
  }

  // Cada sección devuelve slivers, así la lista de movimientos solo construye lo que se ve
  List<Widget> _contenido() {
    final detalle = widget.detalle;
    const margen = EdgeInsets.fromLTRB(16, 0, 16, 24);

    // Si la forma elegida no está descargada no se muestran datos de otra forma
    if (widget.formaPendiente) {
      return const [
        SliverPadding(
          padding: margen,
          sliver: SliverToBoxAdapter(
            child: PanelDetalle(
              titulo: 'Forma',
              hijo: Text(
                'Esta forma todavía no se ha descargado, aparecerá cuando haya conexión',
              ),
            ),
          ),
        ),
      ];
    }

    return switch (_seccion) {
      _Seccion.info => [
        SliverPadding(
          padding: margen,
          sliver: SliverList.list(
            children: [
              PanelEstadisticas(estadisticas: widget.estadisticas),
              const SizedBox(height: 16),
              PanelHabilidades(detalle: detalle),
              const SizedBox(height: 16),
              PanelDatos(detalle: detalle),
            ],
          ),
        ),
      ],
      _Seccion.combate => [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          sliver: SliverList.list(
            children: [
              PanelMatchups(
                tipos: widget.pokemon.types.map((t) => t.name).toList(),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: margen,
          sliver: detalle == null
              ? const SliverToBoxAdapter(
            child: PanelDetalle(
              titulo: 'Movimientos',
              hijo: Text(
                'El detalle todavía no se ha descargado, aparecerá cuando haya conexión',
              ),
            ),
          )
              : PanelMovimientos(
            key: ValueKey(detalle.id),
            movimientos: detalle.movimientos,
          ),
        ),
      ],
      _Seccion.evolucion => [
        SliverPadding(
          padding: margen,
          sliver: SliverList.list(children: [PanelEvolucion(detalle: detalle)]),
        ),
      ],
    };
  }
}