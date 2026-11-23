import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../domain/entities/pokemon.dart';
import '../providers/catalog_state.dart';
import '../widgets/pokemon_card.dart';
import '../../../../core/network/connectivity_monitor.dart';
import '../../../../core/widgets/connectivity_indicator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/sakura.dart';

// Pantalla del catálogo, solo dibuja según el estado que recibe
class CatalogPage extends StatelessWidget {
  const CatalogPage({
    super.key,
    required this.estado,
    required this.alReintentar,
    required this.alCargarMas,
    required this.monitor,
    required this.alBuscar,
  });

  final CatalogState estado;
  final VoidCallback alReintentar;
  final VoidCallback alCargarMas;
  final ConnectivityMonitor monitor;
  final ValueChanged<String> alBuscar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Se avisa cuando el usuario se acerca al final, solo si hay lista
      body: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (estado is CatalogSuccess &&
              n.metrics.pixels >= n.metrics.maxScrollExtent - 300) {
            alCargarMas();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: LayoutBuilder(
                  builder: (context, restricciones) {
                    final ancho = restricciones.maxWidth;
                    final hayLinea = ancho > 170;
                    final haySakura = ancho > 260 &&
                        MediaQuery.textScalerOf(context).scale(1) < 1.4;
                    return Row(
                      children: [
                        const Text(
                          'Pokédex',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        if (hayLinea) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(height: 2, color: Paleta.rosa),
                          ),
                        ],
                        if (haySakura) ...[
                          const SizedBox(width: 4),
                          const RamoSakura(escala: 0.5),
                        ],
                      ],
                    );
                  },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ConnectivityIndicator(monitor: monitor),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: TextField(
                  onChanged: alBuscar,
                  decoration: const InputDecoration(
                    hintText: 'Buscar por nombre',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            // El switch es exhaustivo porque CatalogState es sealed
            switch (estado) {
              CatalogLoading() => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Cargando catálogo',
                  ),
                ),
              ),
              CatalogEmpty() => SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  mensaje:
                  'Todavía no hay Pokémon guardados. Conéctate a internet para descargar el catálogo.',
                  textoAccion: 'Actualizar',
                  alAccionar: alReintentar,
                ),
              ),
              CatalogError(fallo: final failure) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(
                  mensaje: failure.mensaje,
                  alReintentar: alReintentar,
                ),
              ),
              CatalogSuccess(:final pokemons) when pokemons.isEmpty =>
              const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  mensaje: 'No se encontró ningún Pokémon con ese nombre',
                  icono: Icons.search_off,
                ),
              ),
              CatalogSuccess(:final pokemons) => _PokemonGrid(
                pokemons: pokemons,
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _PokemonGrid extends StatelessWidget {
  const _PokemonGrid({required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    // La altura crece con el texto del sistema para que no se corte
    final escala = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 2.0);

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
      // Se agregan columnas solas en pantallas anchas
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 196 + 90 * (escala - 1),
        ),
        // Solo se construyen las tarjetas visibles
        delegate: SliverChildBuilderDelegate(
              (_, i) => PokemonCard(pokemon: pokemons[i]),
          childCount: pokemons.length,
        ),
      ),
    );
  }
}