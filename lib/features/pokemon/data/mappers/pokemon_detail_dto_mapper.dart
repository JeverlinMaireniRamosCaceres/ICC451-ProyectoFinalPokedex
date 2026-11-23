import '../../domain/entities/pokemon_detail.dart';
import '../dtos/pokemon_detail_dto.dart';
import 'pokemon_dto_mapper.dart';

/// Convierte el detalle que llega de la API en la entidad que usa la app
extension PokemonDetailDtoMapper on PokemonDetailDto {
  PokemonDetail aEntidad() {
    return PokemonDetail(
      id: id,
      nombre: nombre,
      altura: altura,
      peso: peso,
      // se reusan los mappers de tipos y estadisticas del catalogo
      tipos: tipos.map((t) => t.aEntidad()).toList(),
      sprite: sprite,
      // si no hay artwork se usa el sprite, como pide el enunciado
      artwork: artwork ?? sprite,
      spriteShiny: spriteShiny,
      artworkShiny: artworkShiny,
      estadisticas: estadisticas.map((s) => s.aEntidad()).toList(),
      habilidades: habilidades
          .map((h) => PokemonAbility(
        nombre: h.nombre,
        esOculta: h.esOculta,
        efecto: _recortar(h.efecto),
      ))
          .toList(),
      movimientos: movimientos
          .map((m) => PokemonMove(
        nombre: m.nombre,
        metodo: m.metodo,
        nivel: m.nivel,
        grupoVersion: m.grupoVersion,
      ))
          .toList(),
      gruposHuevo: gruposHuevo,
      formas: formas
          .map((f) => PokemonForm(
        id: f.id,
        nombre: f.nombre,
        esPredeterminada: f.esPredeterminada,
      ))
          .toList(),
      evoluciones: evoluciones
          .map((e) => PokemonEvolution(
        id: e.id,
        nombre: e.nombre,
        evolucionaDe: e.evolucionaDe,
        trigger: e.trigger,
        nivelMinimo: e.nivelMinimo,
        objeto: e.objeto,
        felicidadMinima: e.felicidadMinima,
        hora: e.hora,
      ))
          .toList(),
    );
  }
}

// El enunciado pide el efecto resumido en 160 caracteres como maximo
String? _recortar(String? texto) {
  if (texto == null || texto.length <= 160) return texto;
  return '${texto.substring(0, 157)}...';
}