import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/texto.dart';
import '../../../../../core/widgets/pokemon_image.dart';
import '../../../domain/entities/pokemon_detail.dart';
import 'panel_detalle.dart';

// Sprite de una especie por su id, del mismo repositorio de imágenes que usa el catálogo
String _urlSprite(int id) =>
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

// Cadena evolutiva, con las ramas una debajo de otra
class PanelEvolucion extends StatelessWidget {
  const PanelEvolucion({super.key, required this.detalle});

  final PokemonDetail? detalle;

  @override
  Widget build(BuildContext context) {
    final d = detalle;
    final Widget contenido;

    if (d == null) {
      contenido = const Text(
        'El detalle todavía no se ha descargado, aparecerá cuando haya conexión',
      );
    } else if (d.evoluciones.length <= 1) {
      // Una cadena de una sola especie es un Pokémon que no evoluciona (RF-DET-04)
      contenido = const Text('No evoluciona');
    } else {
      contenido = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _construirNodos(d.evoluciones, null, 0),
      );
    }

    return PanelDetalle(titulo: 'Evolución', hijo: contenido);
  }
}

// Dibuja cada especie y debajo las que evolucionan de ella, con más sangría en cada nivel
// idPadre es null para buscar la primera especie de la cadena
List<Widget> _construirNodos(
    List<PokemonEvolution> cadena,
    int? idPadre,
    int nivel,
    ) {
  final hijos = cadena.where((e) => e.evolucionaDe == idPadre);

  return [
    for (final e in hijos) ...[
      _FilaEvolucion(especie: e, nivel: nivel),
      ..._construirNodos(cadena, e.id, nivel + 1),
    ],
  ];
}

// Cómo se llega a esta especie, por ejemplo "Nivel 16" o "Usar Thunder stone"
String? _condicion(PokemonEvolution e) {
  final partes = <String>[];

  switch (e.trigger) {
    case 'use-item':
      partes.add(
        e.objeto == null ? 'Usar un objeto' : 'Usar ${nombreLegible(e.objeto!)}',
      );
    case 'trade':
      partes.add(
        e.objeto == null
            ? 'Intercambio'
            : 'Intercambio con ${nombreLegible(e.objeto!)}',
      );
    case 'level-up':
      if (e.nivelMinimo != null) {
        partes.add('Nivel ${e.nivelMinimo}');
      } else if (e.felicidadMinima != null) {
        partes.add('Felicidad ${e.felicidadMinima}');
      } else {
        partes.add('Subir de nivel');
      }
    case final otro?:
      partes.add(nombreLegible(otro));
    case null:
      break;
  }

  if (e.hora == 'day') partes.add('de día');
  if (e.hora == 'night') partes.add('de noche');

  return partes.isEmpty ? null : partes.join(', ');
}

class _FilaEvolucion extends StatelessWidget {
  const _FilaEvolucion({required this.especie, required this.nivel});

  final PokemonEvolution especie;
  final int nivel;

  @override
  Widget build(BuildContext context) {
    final nombre = nombreLegible(especie.nombre);
    // La primera especie de la cadena no tiene condición
    final condicion = nivel == 0 ? null : _condicion(especie);

    return Semantics(
      label: condicion == null ? nombre : '$nombre, $condicion',
      excludeSemantics: true,
      child: Padding(
        padding: EdgeInsets.only(left: 24.0 * nivel, bottom: 12),
        child: Row(
          children: [
            if (nivel > 0)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.subdirectory_arrow_right,
                  size: 20,
                  color: Paleta.rosa,
                ),
              ),
            PokemonImage(
              url: _urlSprite(especie.id),
              size: 56,
              filterQuality: FilterQuality.none,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  if (condicion != null)
                    Text(
                      condicion,
                      style: const TextStyle(color: Paleta.textoSecundario),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}