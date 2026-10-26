import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// Catálogo de Pokémon, la clave es el id de PokeAPI
// PokemonRow evita chocar con la entidad Pokemon del dominio
@DataClassName('PokemonRow')
@TableIndex(name: 'pokemon_name_idx', columns: {#name})
@TableIndex(name: 'pokemon_dex_idx', columns: {#nationalDexNumber})
@TableIndex(name: 'pokemon_generation_idx', columns: {#generationId})
class Pokemons extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get nationalDexNumber => integer()();
  TextColumn get imageUrl => text().nullable()();
  IntColumn get generationId => integer().nullable()();
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

// Favoritos aparte para que el sync no los toque
class Favorites extends Table {
  IntColumn get pokemonId => integer().references(Pokemons, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {pokemonId};
}

// Estado de la sincronización por recurso
class SyncMetadata extends Table {
  TextColumn get resourceKey => text()();
  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  TextColumn get status => text()();
  IntColumn get nextOffset => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {resourceKey};
}

@DriftDatabase(
  tables: [Pokemons, Types, PokemonTypes, Favorites, SyncMetadata],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'pokedex'));

  // Subir si cambia el esquema
  @override
  int get schemaVersion => 1;
}
