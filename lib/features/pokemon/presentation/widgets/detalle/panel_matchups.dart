import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../domain/type_effectiveness.dart';
import '../chip_tipo.dart';
import '../type_colors.dart';
import 'panel_detalle.dart';

// Cuánto daño recibe de cada tipo de ataque, agrupado por multiplicador
class PanelMatchups extends StatelessWidget {
  const PanelMatchups({super.key, required this.tipos});

  final List<String> tipos;

  static const _grupos = [
    (4.0, 'Muy débil (×4)'),
    (2.0, 'Débil (×2)'),
    (0.5, 'Resiste (×0.5)'),
    (0.25, 'Resiste mucho (×0.25)'),
    (0.0, 'Inmune (×0)'),
  ];

  @override
  Widget build(BuildContext context) {
    final efectividad = calcularEfectividad(tipos);

    return PanelDetalle(
      titulo: 'Debilidades y resistencias',
      hijo: tipos.isEmpty
          ? const Text('Sin información de tipos')
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final g in _grupos)
            _GrupoMatchup(
              titulo: g.$2,
              atacantes: efectividad.entries
                  .where((e) => e.value == g.$1)
                  .map((e) => e.key)
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _GrupoMatchup extends StatelessWidget {
  const _GrupoMatchup({required this.titulo, required this.atacantes});

  final String titulo;
  final List<String> atacantes;

  @override
  Widget build(BuildContext context) {
    // Un grupo sin tipos no se muestra
    if (atacantes.isEmpty) return const SizedBox.shrink();

    final nombres = atacantes.map(capitalizar).toList();

    // El lector de pantalla lee el grupo completo en una sola frase
    return Semantics(
      label: '$titulo: ${nombres.join(', ')}',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Paleta.textoSecundario,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final t in atacantes)
                  ChipTipo(etiqueta: capitalizar(t), color: colorDeTipo(t)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}