import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

// Caja con título que usan todas las secciones del detalle
class PanelDetalle extends StatelessWidget {
  const PanelDetalle({super.key, required this.titulo, required this.hijo});

  final String titulo;
  final Widget hijo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Paleta.superficie,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Paleta.borde, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              titulo,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 12),
          hijo,
        ],
      ),
    );
  }
}