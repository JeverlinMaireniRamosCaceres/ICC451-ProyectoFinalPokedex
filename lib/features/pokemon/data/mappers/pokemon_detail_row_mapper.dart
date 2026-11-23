import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_stat.dart';
import '../../domain/entities/pokemon_type.dart';

/// Convierte la entidad del detalle en una fila para guardarla
/// Las listas se convierten en texto JSON con jsonEncode
extension PokemonDetailAFila on PokemonDetail {
  PokemonDetailsCompanion aFila() {
    return PokemonDetailsCompanion.insert(
      pokemonId: Value(id),
      nombre: nombre,
      altura: altura,
      peso: peso,
      sprite: Value(sprite),
      artwork: Value(artwork),
      spriteShiny: Value(spriteShiny),
      artworkShiny: Value(artworkShiny),
      tipos: jsonEncode(
        tipos.map((t) => {'id': t.id, 'nombre': t.name}).toList(),
      ),
      estadisticas: jsonEncode(
        estadisticas.map((s) => {'nombre': s.name, 'valor': s.baseStat}).toList(),
      ),
      habilidades: jsonEncode(
        habilidades
            .map((h) => {
          'nombre': h.nombre,
          'esOculta': h.esOculta,
          'efecto': h.efecto,
        })
            .toList(),
      ),
      movimientos: jsonEncode(
        movimientos
            .map((m) => {
          'nombre': m.nombre,
          'metodo': m.metodo,
          'nivel': m.nivel,
          'grupoVersion': m.grupoVersion,
        })
            .toList(),
      ),
      gruposHuevo: jsonEncode(gruposHuevo),
      formas: jsonEncode(
        formas
            .map((f) => {
          'id': f.id,
          'nombre': f.nombre,
          'esPredeterminada': f.esPredeterminada,
        })
            .toList(),
      ),
      evoluciones: jsonEncode(
        evoluciones
            .map((e) => {
          'id': e.id,
          'nombre': e.nombre,
          'evolucionaDe': e.evolucionaDe,
          'trigger': e.trigger,
          'nivelMinimo': e.nivelMinimo,
          'objeto': e.objeto,
          'felicidadMinima': e.felicidadMinima,
          'hora': e.hora,
        })
            .toList(),
      ),
      actualizadoEn: DateTime.now(),
    );
  }
}

/// Convierte la fila de la base en la entidad del detalle
/// El texto JSON de cada lista se vuelve a convertir en objetos con jsonDecode
extension PokemonDetailRowMapper on PokemonDetailRow {
  PokemonDetail aEntidad() {
    return PokemonDetail(
      id: pokemonId,
      nombre: nombre,
      altura: altura,
      peso: peso,
      sprite: sprite,
      artwork: artwork,
      spriteShiny: spriteShiny,
      artworkShiny: artworkShiny,
      tipos: _leer(
        tipos,
            (m) => PokemonType(id: m['id'] as int, name: m['nombre'] as String),
      ),
      estadisticas: _leer(
        estadisticas,
            (m) => PokemonStat(name: m['nombre'] as String, baseStat: m['valor'] as int),
      ),
      habilidades: _leer(
        habilidades,
            (m) => PokemonAbility(
          nombre: m['nombre'] as String,
          esOculta: m['esOculta'] as bool,
          efecto: m['efecto'] as String?,
        ),
      ),
      movimientos: _leer(
        movimientos,
            (m) => PokemonMove(
          nombre: m['nombre'] as String,
          metodo: m['metodo'] as String,
          nivel: m['nivel'] as int,
          grupoVersion: m['grupoVersion'] as String,
        ),
      ),
      gruposHuevo: (jsonDecode(gruposHuevo) as List<dynamic>).cast<String>(),
      formas: _leer(
        formas,
            (m) => PokemonForm(
          id: m['id'] as int,
          nombre: m['nombre'] as String,
          esPredeterminada: m['esPredeterminada'] as bool,
        ),
      ),
      evoluciones: _leer(
        evoluciones,
            (m) => PokemonEvolution(
          id: m['id'] as int,
          nombre: m['nombre'] as String,
          evolucionaDe: m['evolucionaDe'] as int?,
          trigger: m['trigger'] as String?,
          nivelMinimo: m['nivelMinimo'] as int?,
          objeto: m['objeto'] as String?,
          felicidadMinima: m['felicidadMinima'] as int?,
          hora: m['hora'] as String?,
        ),
      ),
    );
  }
}

// Convierte el texto JSON de una lista en objetos
// convertir es la funcion que sabe crear cada objeto a partir de su mapa
List<T> _leer<T>(String texto, T Function(Map<String, dynamic>) convertir) {
  return (jsonDecode(texto) as List<dynamic>)
      .map((e) => convertir(e as Map<String, dynamic>))
      .toList();
}