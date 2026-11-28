import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../providers/pokemon_providers.dart';
import 'detail_page.dart';

// Lee el detalle guardado y se lo pasa a DetailPage
// Guarda la forma elegida, que solo importa mientras esta pantalla está abierta
class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({
    super.key,
    required this.pokemon,
    required this.etiquetaHero,
  });

  final Pokemon pokemon;
  final String etiquetaHero;

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  // null mientras se ve la forma original
  int? _formaElegida;
  // Si se ve la imagen shiny, el alternador de la cabecera lo cambia
  bool _shiny = false;

  // Las formas no están en el catálogo, así que se arma un Pokemon con su detalle
  // para reusar la cabecera, las estadísticas y las debilidades
  // baseStatTotal queda en 0 porque el detalle no lo usa, la suma se calcula en el panel
  Pokemon _pokemonDeForma(PokemonDetail forma) {
    return Pokemon(
      id: forma.id,
      name: forma.nombre,
      nationalDexNumber: widget.pokemon.nationalDexNumber,
      types: forma.tipos,
      imageUrl: forma.sprite,
      artworkUrl: forma.artwork,
      generationId: widget.pokemon.generationId,
      stats: forma.estadisticas,
    );
  }

  @override
  Widget build(BuildContext context) {
    // El detalle del Pokémon original trae la lista de formas
    final base = ref.watch(detalleProvider(widget.pokemon.id)).value;
    // Sube cuando regresa la conexión, para que la imagen vuelva a intentar cargar
    final reintentoImagen = ref.watch(conexionRecuperadaProvider);

    // Si no se eligió otra forma es el mismo provider de arriba, no se pide dos veces
    final idActual = _formaElegida ?? widget.pokemon.id;
    final detalleActual = ref.watch(detalleProvider(idActual)).value;


    final esOriginal = idActual == widget.pokemon.id;
    // Mientras la forma elegida no esté descargada se deja la cabecera original
    final pokemon = (esOriginal || detalleActual == null)
        ? widget.pokemon
        : _pokemonDeForma(detalleActual);

    return DetailPage(
      pokemon: pokemon,
      detalle: detalleActual,
      reintentoImagen: reintentoImagen,
      etiquetaHero: widget.etiquetaHero,
      formas: (base ?? detalleActual)?.formas ?? const <PokemonForm>[],
      nombreBase: widget.pokemon.name,
      idForma: idActual,
      formaPendiente: !esOriginal && detalleActual == null,
      alElegirForma: (id) => setState(() => _formaElegida = id),
      esShiny: _shiny,
      alCambiarShiny: (valor) => setState(() => _shiny = valor),
      idBase: widget.pokemon.id,
    );
  }
}