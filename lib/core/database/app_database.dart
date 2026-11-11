import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// Las tablas se separaron por grupo, el catalogo que viene de la API,
// el control de la sincronizacion y los datos del usuario
import 'tables/catalog_tables.dart';
import 'tables/sync_tables.dart';
import 'tables/user_tables.dart';

part 'app_database.g.dart';

/// Es la base de datos local de la aplicacion
/// Son todas las tablas que usa drift
@DriftDatabase(
  tables: [
    Pokemons,
    Types,
    PokemonTypes,
    PokemonStats,
    Favorites,
    SyncMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  // Crea la base de datos en el telefono, pone el nombre de pokedex
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'pokedex'));

  // Es la version de la estructura de las tablas
  // Si cambia una tabla, se sube la version y se escribe una migracion
  @override
  int get schemaVersion => 1;
}
