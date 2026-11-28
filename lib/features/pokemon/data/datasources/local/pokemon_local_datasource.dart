import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';
import '../../../domain/entities/pokemon.dart';
import '../../../domain/entities/pokemon_type.dart';
import '../../mappers/pokemon_detail_row_mapper.dart';
import '../../../domain/entities/pokemon_detail.dart';
import '../../../domain/repositories/pokemon_repository.dart';

// Este datasource entrega un pokemon con sus tipos ya agrupados
class PokemonWithTypes {
  const PokemonWithTypes(this.pokemon, this.types);

  final PokemonRow pokemon;
  final List<TypeRow> types;
}

// Consultas del catálogo sobre la base local, la base en sí vive en core
class PokemonLocalDataSource {
  PokemonLocalDataSource(this._db);

  final AppDatabase _db;

  // Catálogo en un solo join, se actualiza solo cuando cambia la base
  // Los filtros y el orden se aplican en la consulta
  Stream<List<PokemonWithTypes>> observarCatalogo({
    String busqueda = '',
    String? tipo,
    int? generacion,
    OrdenCatalogo orden = OrdenCatalogo.numero,
  }) {
    final query = _db.select(_db.pokemons).join([
      // trae el pokemon aunque no tenga tipos
      leftOuterJoin(
        _db.pokemonTypes,
        _db.pokemonTypes.pokemonId.equalsExp(_db.pokemons.id),
      ),
      leftOuterJoin(
        _db.types,
        _db.types.id.equalsExp(_db.pokemonTypes.typeId),
      ),
    ]);

    // Si hay texto, solo trae los Pokemon que lo tengan en el nombre
    // LIKE con % antes y despues busca el texto en cualquier parte
    if (busqueda.isNotEmpty) {
      query.where(_db.pokemons.name.like('%$busqueda%'));
    }

    // Solo los Pokemon de esa generacion
    if (generacion != null) {
      query.where(_db.pokemons.generationId.equals(generacion));
    }

    // Solo los Pokemon que tienen ese tipo
    // Se usa una subconsulta con sus ids, porque filtrar directo en el join
    // quitaria la fila del otro tipo y el Pokemon se veria con un solo tipo
    if (tipo != null) {
      final conTipo = _db.selectOnly(_db.pokemonTypes).join([
        innerJoin(_db.types, _db.types.id.equalsExp(_db.pokemonTypes.typeId)),
      ])
        ..addColumns([_db.pokemonTypes.pokemonId])
        ..where(_db.types.name.equals(tipo));
      query.where(_db.pokemons.id.isInQuery(conTipo));
    }

    query.orderBy([
      switch (orden) {
        OrdenCatalogo.numero => OrderingTerm.asc(_db.pokemons.nationalDexNumber),
        OrdenCatalogo.nombre => OrderingTerm.asc(_db.pokemons.name),
        OrdenCatalogo.total => OrderingTerm.desc(_db.pokemons.baseStatTotal),
      },
      // si empatan, se ordena por numero, y los tipos por slot
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
  Stream<SyncMetadataData?> observarMetadatosSincronizacion(String resourceKey) {
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

  // Detalle de un Pokemon, null si todavia no se ha descargado
  // Es un Stream, asi la pantalla se actualiza sola cuando se guarda
  Stream<PokemonDetailRow?> observarDetalle(int id) {
    return (_db.select(_db.pokemonDetails)
      ..where((d) => d.pokemonId.equals(id)))
        .watchSingleOrNull();
  }

  // Guarda el detalle, si ya existe lo reemplaza
  Future<void> guardarDetalle(PokemonDetail detalle) {
    return _db.into(_db.pokemonDetails).insertOnConflictUpdate(detalle.aFila());
  }

  // Ids de los favoritos, se actualiza solo cuando cambia la tabla
  // Sirve para saber qué corazones van marcados sin traer los Pokémon completos
  Stream<Set<int>> observarIdsFavoritos() {
    return _db
        .select(_db.favorites)
        .watch()
        .map((filas) => filas.map((f) => f.pokemonId).toSet());
  }

  // Favoritos con sus tipos, del más reciente al más antiguo
  // El inner join descarta cualquier favorito sin su Pokemon en el catálogo
  Stream<List<PokemonWithTypes>> observarFavoritos() {
    final query = _db.select(_db.favorites).join([
      innerJoin(
        _db.pokemons,
        _db.pokemons.id.equalsExp(_db.favorites.pokemonId),
      ),
      leftOuterJoin(
        _db.pokemonTypes,
        _db.pokemonTypes.pokemonId.equalsExp(_db.pokemons.id),
      ),
      leftOuterJoin(
        _db.types,
        _db.types.id.equalsExp(_db.pokemonTypes.typeId),
      ),
    ]);

    // createdAt se guarda en segundos, el id desempata para que las filas
    // de un mismo Pokemon queden juntas y _agrupar funcione
    query.orderBy([
      OrderingTerm.desc(_db.favorites.createdAt),
      OrderingTerm.asc(_db.pokemons.id),
      OrderingTerm.asc(_db.pokemonTypes.slot),
    ]);

    return query.watch().map(_agrupar);
  }

  // Marca el favorito si no lo era, y lo quita si lo era
  // Leer y escribir van en una transacción para que dos toques seguidos no se pisen
  Future<void> alternarFavorito(int pokemonId) {
    return _db.transaction(() async {
      final filtro = _db.favorites.pokemonId.equals(pokemonId);
      final existente = await (_db.select(_db.favorites)
        ..where((f) => filtro))
          .getSingleOrNull();

      if (existente == null) {
        await _db.into(_db.favorites).insert(
          FavoritesCompanion.insert(
            pokemonId: Value(pokemonId),
            createdAt: DateTime.now(),
          ),
        );
      } else {
        await (_db.delete(_db.favorites)..where((f) => filtro)).go();
      }
    });
  }

  // Ids de los favoritos que todavía no tienen su detalle guardado
  // El left join deja la fila aunque no haya detalle, y el where se queda con esas
  Future<List<int>> favoritosSinDetalle() async {
    final consulta = _db.select(_db.favorites).join([
      leftOuterJoin(
        _db.pokemonDetails,
        _db.pokemonDetails.pokemonId.equalsExp(_db.favorites.pokemonId),
      ),
    ])..where(_db.pokemonDetails.pokemonId.isNull());

    final filas = await consulta.get();
    return filas.map((f) => f.readTable(_db.favorites).pokemonId).toList();
  }

}
