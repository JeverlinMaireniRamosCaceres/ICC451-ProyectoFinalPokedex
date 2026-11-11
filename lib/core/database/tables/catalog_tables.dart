import 'package:drift/drift.dart';

// Catalogo de Pokémon, la clave es el id de PokeAPI
// Los indices son para que las busquedas por nombre, el orden por numero,
// las estadisticas sean mas rapidas
@DataClassName('PokemonRow')
@TableIndex(name: 'pokemon_name_idx', columns: {#name})
@TableIndex(name: 'pokemon_dex_idx', columns: {#nationalDexNumber})
@TableIndex(name: 'pokemon_generation_idx', columns: {#generationId})
@TableIndex(name: 'pokemon_stat_total_idx', columns: {#baseStatTotal})

class Pokemons extends Table {

  // id de la pokeapi
  IntColumn get id => integer()();

  TextColumn get name => text()();
  IntColumn get nationalDexNumber => integer()();

  // url del sprite
  TextColumn get imageUrl => text().nullable()();

  // url del artwork
  TextColumn get artworkUrl => text().nullable()();

  IntColumn get generationId => integer().nullable()();

  // suma de las ultimas estadisticas
  IntColumn get baseStatTotal => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Tipos de Pokémon
@DataClassName('TypeRow')
class Types extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// Une cada Pokémon con sus tipos
@DataClassName('PokemonTypeRow')
class PokemonTypes extends Table {
  IntColumn get pokemonId => integer().references(Pokemons, #id)();
  IntColumn get typeId => integer().references(Types, #id)();
  // 1 es el principal, 2 el secundario
  IntColumn get slot => integer()();

  @override
  Set<Column> get primaryKey => {pokemonId, typeId};
}

@DataClassName('PokemonStatRow')
// Son las 6 estadisticas base de cada pokemon
// Es una fila por estadistica
class PokemonStats extends Table {
  IntColumn get pokemonId => integer().references(Pokemons, #id)();
  TextColumn get statName => text()();
  IntColumn get baseStat => integer()();

  @override
  Set<Column> get primaryKey => {pokemonId, statName};
}
