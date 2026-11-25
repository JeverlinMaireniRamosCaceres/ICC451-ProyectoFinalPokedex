import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../domain/entities/pokemon_detail.dart';
import 'chip_opcion.dart';

// Chips para cambiar de forma (Mega, regional, etc.), solo aparece si hay más de una
class SelectorFormas extends StatelessWidget {
  const SelectorFormas({
    super.key,
    required this.formas,
    required this.nombreBase,
    required this.idElegido,
    required this.alElegir,
  });

  final List<PokemonForm> formas;
  final String nombreBase;
  final int idElegido;
  final ValueChanged<int> alElegir;

  // "charizard-mega-x" se muestra como "Mega x", la predeterminada como "Normal"
  String _etiqueta(PokemonForm forma) {
    if (forma.esPredeterminada) return 'Normal';
    final prefijo = '$nombreBase-';
    final nombre = forma.nombre.startsWith(prefijo)
        ? forma.nombre.substring(prefijo.length)
        : forma.nombre;
    return nombreLegible(nombre);
  }

  @override
  Widget build(BuildContext context) {
    if (formas.length <= 1) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Forma', style: TextStyle(color: Paleta.textoSecundario)),
          const SizedBox(height: 4),
          // Wrap pasa los chips a otra línea si no caben (RNF-ACC-04)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final forma in formas)
                ChipOpcion(
                  etiqueta: _etiqueta(forma),
                  elegido: forma.id == idElegido,
                  alElegir: () => alElegir(forma.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}