import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../domain/entities/pokemon_detail.dart';
import 'chip_opcion.dart';
import 'juegos.dart';
import 'panel_detalle.dart';

// Movimientos del Pokémon, por defecto los de un juego reciente y por método Nivel (RF-DET-05)
// Es un sliver para que la lista larga se construya solo con las filas que se ven
class PanelMovimientos extends StatefulWidget {
  const PanelMovimientos({super.key, required this.movimientos});

  final List<PokemonMove> movimientos;

  @override
  State<PanelMovimientos> createState() => _PanelMovimientosState();
}

class _PanelMovimientosState extends State<PanelMovimientos> {
  // Lo elegido solo importa a este panel, por eso no necesita provider
  String? _juego;
  String _metodo = 'level-up';
  bool _porNivel = true;

  // La lista de juegos es larga, por eso se elige en una hoja inferior
  Future<void> _elegirJuego(List<String> juegos, String actual) async {
    final elegido = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Paleta.superficie,
      builder: (contexto) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final j in juegos)
              ListTile(
                title: Text(nombreJuego(j)),
                selected: j == actual,
                onTap: () => Navigator.pop(contexto, j),
              ),
          ],
        ),
      ),
    );
    if (elegido != null && mounted) setState(() => _juego = elegido);
  }

  @override
  Widget build(BuildContext context) {
    final todos = widget.movimientos;

    if (todos.isEmpty) {
      return const SliverToBoxAdapter(
        child: PanelDetalle(
          titulo: 'Movimientos',
          hijo: Text('Sin información de movimientos'),
        ),
      );
    }

    // Los juegos en los que aprende movimientos, del más nuevo al más viejo
    final juegos = todos.map((m) => m.grupoVersion).toSet().toList()
      ..sort((a, b) => posicionJuego(a).compareTo(posicionJuego(b)));

    // Escarlata y Púrpura si lo tiene, si no el más reciente
    final juego = (_juego != null && juegos.contains(_juego))
        ? _juego!
        : (juegos.contains('scarlet-violet') ? 'scarlet-violet' : juegos.first);

    // Los cuatro métodos básicos siempre, más los otros que aparezcan en los datos
    final metodos = [
      ...metodosBase,
      ...todos
          .map((m) => m.metodo)
          .toSet()
          .where((m) => m.isNotEmpty && !metodosBase.contains(m)),
    ];

    // Se filtra por juego y método y se ordena, solo cuando cambia algo elegido
    final lista =
    todos
        .where((m) => m.grupoVersion == juego && m.metodo == _metodo)
        .toList()
      ..sort((a, b) {
        if (_porNivel) {
          final porNivel = a.nivel.compareTo(b.nivel);
          if (porNivel != 0) return porNivel;
        }
        return a.nombre.compareTo(b.nombre);
      });

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: PanelDetalle(
            titulo: 'Movimientos',
            hijo: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Juego',
                  style: TextStyle(color: Paleta.textoSecundario),
                ),
                const SizedBox(height: 4),
                OutlinedButton.icon(
                  onPressed: () => _elegirJuego(juegos, juego),
                  icon: const Icon(Icons.videogame_asset_outlined),
                  label: Text(nombreJuego(juego)),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Método',
                  style: TextStyle(color: Paleta.textoSecundario),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final m in metodos)
                      ChipOpcion(
                        etiqueta: nombreMetodo(m),
                        elegido: _metodo == m,
                        alElegir: () => setState(() => _metodo = m),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Orden',
                  style: TextStyle(color: Paleta.textoSecundario),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    ChipOpcion(
                      etiqueta: 'Por nivel',
                      elegido: _porNivel,
                      alElegir: () => setState(() => _porNivel = true),
                    ),
                    ChipOpcion(
                      etiqueta: 'Por nombre',
                      elegido: !_porNivel,
                      alElegir: () => setState(() => _porNivel = false),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        if (lista.isEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('No aprende movimientos de este método en este juego'),
            ),
          )
        else
        // Solo se construyen las filas que se ven en pantalla (RNF-REN-01)
          SliverList.builder(
            itemCount: lista.length,
            itemBuilder: (_, i) => _FilaMovimiento(movimiento: lista[i]),
          ),
      ],
    );
  }
}

class _FilaMovimiento extends StatelessWidget {
  const _FilaMovimiento({required this.movimiento});

  final PokemonMove movimiento;

  @override
  Widget build(BuildContext context) {
    // En los movimientos por nivel se muestra el nivel, en los demás el método
    final detalle = movimiento.metodo == 'level-up'
        ? (movimiento.nivel == 0 ? 'Sin nivel' : 'Nv. ${movimiento.nivel}')
        : nombreMetodo(movimiento.metodo);

    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Paleta.borde)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                nombreLegible(movimiento.nombre),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              detalle,
              style: const TextStyle(color: Paleta.textoSecundario),
            ),
          ],
        ),
      ),
    );
  }
}