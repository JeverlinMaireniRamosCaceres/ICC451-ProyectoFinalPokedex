import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../domain/entities/pokemon_detail.dart';
import 'panel_detalle.dart';

// Altura, peso y grupos huevo, vienen del detalle descargado
class PanelDatos extends StatelessWidget {
  const PanelDatos({super.key, required this.detalle});

  final PokemonDetail? detalle;

  @override
  Widget build(BuildContext context) {
    final d = detalle;

    return PanelDetalle(
      titulo: 'Datos',
      hijo: d == null
          ? const Text(
        'El detalle todavía no se ha descargado, aparecerá cuando haya conexión',
      )
          : Column(
        children: [
          // La API manda la altura en decímetros y el peso en hectogramos
          _Dato(
            etiqueta: 'Altura',
            valor: '${(d.altura / 10).toStringAsFixed(1)} m',
          ),
          _Dato(
            etiqueta: 'Peso',
            valor: '${(d.peso / 10).toStringAsFixed(1)} kg',
          ),
          _Dato(
            etiqueta: 'Grupos huevo',
            valor: d.gruposHuevo.isEmpty
                ? 'Ninguno'
                : d.gruposHuevo.map(nombreLegible).join(', '),
          ),
        ],
      ),
    );
  }
}

class _Dato extends StatelessWidget {
  const _Dato({required this.etiqueta, required this.valor});

  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 16,
          runSpacing: 2,
          children: [
            Text(
              etiqueta,
              style: const TextStyle(color: Paleta.textoSecundario),
            ),
            Text(
              valor,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}