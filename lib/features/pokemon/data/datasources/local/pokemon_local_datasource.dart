import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';
import '../../../domain/entities/pokemon.dart';
import '../../../domain/entities/pokemon_type.dart';

// Un pokémon con sus tipos ya agrupados, es lo que entrega este data source
class PokemonWithTypes {
  const PokemonWithTypes(this.pokemon, this.types);

  final PokemonRow pokemon;
  final List<TypeRow> types;
}

// Consultas del catálogo sobre la base local, la base en sí vive en core
class PokemonLocalDataSource {
  PokemonLocalDataSource(this._db);

  final AppDatabase _db;

  // Catálogo completo en un solo join, se actualiza solo cuando cambia la base
  Stream<List<PokemonWithTypes>> watchCatalog() {
    final query =
        _db.select(_db.pokemons).join([
          leftOuterJoin(
            _db.pokemonTypes,
            _db.pokemonTypes.pokemonId.equalsExp(_db.pokemons.id),
          ),
          leftOuterJoin(
            _db.types,
            _db.types.id.equalsExp(_db.pokemonTypes.typeId),
          ),
        ])..orderBy([
          OrderingTerm.asc(_db.pokemons.nationalDexNumber),
          OrderingTerm.asc(_db.pokemonTypes.slot),
        ]);

    return query.watch().map(_agrupar);
  }

  // El join da una fila por tipo, aquí se juntan en un solo pokémon
  // Un Map mantiene el orden en que se insertan, que ya viene por Pokédex y slot
  List<PokemonWithTypes> _agrupar(List<TypedResult> filas) {
    final pokemons = <int, PokemonRow>{};
    final tipos = <int, List<TypeRow>>{};

    for (final fila in filas) {
      final row = fila.readTable(_db.pokemons);
      final tipo = fila.readTableOrNull(_db.types);

      pokemons[row.id] = row;
      final lista = tipos.putIfAbsent(row.id, () => []);
      if (tipo != null) lista.add(tipo);
    }

    return pokemons.values
        .map((p) => PokemonWithTypes(p, tipos[p.id]!))
        .toList();
  }

  // Estado de la sincronización de un recurso, null si nunca se ha sincronizado
  Stream<SyncMetadataData?> watchSyncMetadata(String resourceKey) {
    return (_db.select(
      _db.syncMetadata,
    )..where((m) => m.resourceKey.equals(resourceKey))).watchSingleOrNull();
  }

  // Inserta o actualiza el catálogo en una sola transacción
  Future<void> upsertPokemons(List<Pokemon> lista) {
    return _db.transaction(() async {
      final now = DateTime.now();
      final ids = lista.map((p) => p.id).toList();

      await (_db.delete(
        _db.pokemonTypes,
      )..where((r) => r.pokemonId.isIn(ids))).go();
      await (_db.delete(
        _db.pokemonStats,
      )..where((r) => r.pokemonId.isIn(ids))).go();

      await _db.batch((b) {
        // Si el id ya existe se actualiza, si no se inserta (sin duplicados)
        b.insertAllOnConflictUpdate(
          _db.pokemons,
          lista.map((p) {
            return PokemonsCompanion.insert(
              id: Value(p.id),
              name: p.name,
              nationalDexNumber: p.nationalDexNumber,
              imageUrl: Value(p.imageUrl),
              artworkUrl: Value(p.artworkUrl),
              generationId: Value(p.generationId),
              baseStatTotal: Value(p.baseStatTotal),
              updatedAt: now,
            );
          }).toList(),
        );

        final tipos = <int, PokemonType>{};
        for (final p in lista) {
          for (final t in p.types) {
            tipos[t.id] = t;
          }
        }
        b.insertAllOnConflictUpdate(
          _db.types,
          tipos.values.map((t) {
            return TypesCompanion(id: Value(t.id), name: Value(t.name));
          }).toList(),
        );

        // La relación con su slot (1 principal, 2 secundario)
        for (final p in lista) {
          for (var i = 0; i < p.types.length; i++) {
            b.insert(
              _db.pokemonTypes,
              PokemonTypesCompanion.insert(
                pokemonId: p.id,
                typeId: p.types[i].id,
                slot: i + 1,
              ),
            );
          }
        }

        for (final p in lista) {
          for (final s in p.stats) {
            b.insert(
              _db.pokemonStats,
              PokemonStatsCompanion.insert(
                pokemonId: p.id,
                statName: s.name,
                baseStat: s.baseStat,
              ),
            );
          }
        }
      });
    });
  }
}
