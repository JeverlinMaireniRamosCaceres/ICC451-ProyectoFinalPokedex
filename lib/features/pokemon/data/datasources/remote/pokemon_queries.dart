/// Consulta GraphQL que solicita una pagina del catalogo a la pokeapi
///
/// Esta trae unicamente los campos que la app necesita de cada pokemon, que son
/// Id
/// Nombre
/// Numero de pokedex
/// Tipos
/// Sprite y artwork
/// Generacion
/// Seis estadisticas
///
/// Ademas trae el total de pokemon disponibles en la API
///
/// Otros detalles de la consulta:
/// - limit y offset son las variables que definen la paginacion, que es de 20 en 20
/// - order by para ordenar
/// is_default = true para traer solo la forma principal de cada pokemon
///
/// La r antes de las comillas evita que Dart confunda $limit y $offset con variables de Dart
const String catalogoPokemonQuery = r'''
query CatalogoPokemon($limit: Int!, $offset: Int!) {
  pokemon(
    limit: $limit
    offset: $offset
    order_by: { id: asc }
    where: { is_default: { _eq: true } }
  ) {
    id
    name
    pokemon_species_id
    pokemontypes(order_by: { slot: asc }) {
      slot
      type { id name }
    }
    pokemonsprites {
      sprite: sprites(path: "front_default")
      artwork: sprites(path: "other.official-artwork.front_default")
    }
    pokemonspecy {
      generation_id
    }
    pokemonstats {
      base_stat
      stat { name }
    }
  }
  pokemon_aggregate(where: { is_default: { _eq: true } }) {
    aggregate { count }
  }
}
''';

// Query del detalle de un Pokemon
// Se pide por id
// No pide el nombre, estadisticas ni tipos porque ya se guardaron en el catalogo
const String detallePokemonQuery = r'''
query DetallePokemon($id: Int!) {
  pokemon(where: { id: { _eq: $id } }) {
    id
    height
    weight
    pokemonsprites {
      shiny: sprites(path: "front_shiny")
      artworkShiny: sprites(path: "other.official-artwork.front_shiny")
    }
    pokemonabilities(order_by: { slot: asc }) {
      is_hidden
      ability { name }
    }
    pokemonmoves(distinct_on: move_id, order_by: { move_id: asc }) {
      move { name }
    }
    pokemonspecy {
      pokemons(order_by: { id: asc }) {
        id
        name
        is_default
      }
      evolutionchain {
        pokemonspecies(order_by: { id: asc }) {
          id
          name
          evolves_from_species_id
        }
      }
    }
  }
}
''';
