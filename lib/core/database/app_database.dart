import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../../features/pokemon/domain/entities/pokemon.dart';
import '../../features/pokemon/domain/entities/pokemon_type.dart';

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

  // Inserta o actualiza el catálogo en una sola transacción
  Future<void> upsertPokemons(List<Pokemon> lista) {
    return transaction(() async {
      final now = DateTime.now();

      // Se borran las relaciones viejas
      await (delete(pokemonTypes)
        ..where((r) => r.pokemonId.isIn(lista.map((p) => p.id))))
          .go();

      await batch((b) {
        b.insertAllOnConflictUpdate(
          pokemons,
          lista.map((p) {
            return PokemonsCompanion.insert(
              id: Value(p.id),
              name: p.name,
              nationalDexNumber: p.nationalDexNumber,
              imageUrl: Value(p.imageUrl),
              generationId: Value(p.generationId),
              updatedAt: now,
            );
          }).toList(),
        );

        // Los tipos se repiten entre pokémon, se guardan una vez por id
        final tipos = <int, PokemonType>{};
        for (final p in lista) {
          for (final t in p.types) {
            tipos[t.id] = t;
          }
        }
        b.insertAllOnConflictUpdate(
          types,
          tipos.values.map((t) {
            return TypesCompanion(id: Value(t.id), name: Value(t.name));
          }).toList(),
        );

        // La relación con su slot (1 principal, 2 secundario)
        for (final p in lista) {
          for (var i = 0; i < p.types.length; i++) {
            b.insert(
              pokemonTypes,
              PokemonTypesCompanion.insert(
                pokemonId: p.id,
                typeId: p.types[i].id,
                slot: i + 1,
              ),
            );
          }
        }
      });
    });
  }
}
