import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

// Opción elegible con el estilo de la app, la usan las pestañas y los filtros del detalle
class ChipOpcion extends StatelessWidget {
  const ChipOpcion({
    super.key,
    required this.etiqueta,
    required this.elegido,
    required this.alElegir,
  });

  final String etiqueta;
  final bool elegido;
  final VoidCallback alElegir;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(etiqueta),
      selected: elegido,
      onSelected: (_) => alElegir(),
      showCheckmark: false,
      selectedColor: Paleta.rosa,
      backgroundColor: Paleta.superficie,
      side: const BorderSide(color: Paleta.borde, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: elegido ? Paleta.tinta : Paleta.texto,
      ),
    );
  }
}