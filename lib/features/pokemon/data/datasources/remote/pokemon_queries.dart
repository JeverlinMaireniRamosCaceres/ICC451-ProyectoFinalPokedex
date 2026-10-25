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