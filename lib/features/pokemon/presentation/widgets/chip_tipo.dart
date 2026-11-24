import 'package:flutter/material.dart';

import 'type_colors.dart';

// Etiqueta del tipo con el color del tipo de fondo y texto legible encima
class ChipTipo extends StatelessWidget {
  const ChipTipo({super.key, required this.etiqueta, required this.color});

  final String etiqueta;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        etiqueta,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorTextoSobre(color),
        ),
      ),
    );
  }
}