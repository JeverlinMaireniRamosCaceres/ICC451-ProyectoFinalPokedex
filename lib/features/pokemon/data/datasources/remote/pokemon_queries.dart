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
