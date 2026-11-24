import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../domain/entities/pokemon_stat.dart';
import 'panel_detalle.dart';

// La API manda los nombres de las estadísticas en inglés
const _nombresEstadisticas = {
  'hp': 'PS',
  'attack': 'Ataque',
  'defense': 'Defensa',
  'special-attack': 'At. esp.',
  'special-defense': 'Def. esp.',
  'speed': 'Velocidad',
};

// Una barra por estadística y el total abajo
class PanelEstadisticas extends StatelessWidget {
  const PanelEstadisticas({super.key, required this.estadisticas});

  final List<PokemonStat> estadisticas;

  @override
  Widget build(BuildContext context) {
    final total = estadisticas.fold<int>(0, (suma, s) => suma + s.baseStat);

    return PanelDetalle(
      titulo: 'Estadísticas base',
      hijo: estadisticas.isEmpty
          ? const Text('Las estadísticas todavía no están disponibles')
          : Column(
        children: [
          for (final s in estadisticas)
            _FilaEstadistica(nombre: s.name, valor: s.baseStat),
          const Divider(color: Paleta.borde, height: 20),
          MergeSemantics(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  '$total',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilaEstadistica extends StatelessWidget {
  const _FilaEstadistica({required this.nombre, required this.valor});

  final String nombre;
  final int valor;

  // 255 es el valor base más alto que puede tener una estadística
  // El porcentaje y el largo de la barra se calculan contra ese máximo
  static const _maximo = 255;

  @override
  Widget build(BuildContext context) {
    final fraccion = (valor / _maximo).clamp(0.0, 1.0);
    final porcentaje = (fraccion * 100).round();
    final etiqueta = _nombresEstadisticas[nombre] ?? capitalizar(nombre);

    // El lector de pantalla lee la fila entera, el valor también está en texto
    // así que no depende solo de la barra ni del color (RNF-ACC-05)
    return Semantics(
      label: '$etiqueta: $valor de $_maximo, $porcentaje por ciento',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(etiqueta)),
                Text(
                  '$valor ($porcentaje%)',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // La barra se llena al abrir la pantalla
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: fraccion),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (_, progreso, _) => LinearProgressIndicator(
                value: progreso,
                minHeight: 10,
                color: Paleta.rosa,
                backgroundColor: Paleta.fondo,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}