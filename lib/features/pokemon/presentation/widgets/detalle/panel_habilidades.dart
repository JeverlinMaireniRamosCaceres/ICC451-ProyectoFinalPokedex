import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../domain/entities/pokemon_detail.dart';
import 'panel_detalle.dart';

// Habilidades con la marca Oculta y el efecto resumido
class PanelHabilidades extends StatelessWidget {
  const PanelHabilidades({super.key, required this.detalle});

  final PokemonDetail? detalle;

  @override
  Widget build(BuildContext context) {
    final d = detalle;
    final Widget contenido;

    if (d == null) {
      contenido = const Text(
        'El detalle todavía no se ha descargado, aparecerá cuando haya conexión',
      );
    } else if (d.habilidades.isEmpty) {
      contenido = const Text('No tiene habilidades registradas');
    } else {
      contenido = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final h in d.habilidades) _FilaHabilidad(habilidad: h),
        ],
      );
    }

    return PanelDetalle(titulo: 'Habilidades', hijo: contenido);
  }
}

class _FilaHabilidad extends StatelessWidget {
  const _FilaHabilidad({required this.habilidad});

  final PokemonAbility habilidad;

  @override
  Widget build(BuildContext context) {
    final efecto = habilidad.efecto;

    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  nombreLegible(habilidad.nombre),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                if (habilidad.esOculta) const _EtiquetaOculta(),
              ],
            ),
            if (efecto != null) ...[
              const SizedBox(height: 4),
              Text(
                efecto,
                style: const TextStyle(color: Paleta.textoSecundario),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Marca de habilidad oculta, con icono y texto para no depender solo del color
class _EtiquetaOculta extends StatelessWidget {
  const _EtiquetaOculta();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Paleta.rosa, width: 1.5),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.visibility_off, size: 14, color: Paleta.rosa),
          SizedBox(width: 4),
          Text(
            'Oculta',
            style: TextStyle(
              color: Paleta.rosa,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}