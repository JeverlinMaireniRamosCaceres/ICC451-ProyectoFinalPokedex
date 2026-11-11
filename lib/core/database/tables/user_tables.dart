import 'package:drift/drift.dart';

import 'catalog_tables.dart';

// Datos del usuario
// Estan en una tabla diferente del catálogo para que el sync no los toque
class Favorites extends Table {
  IntColumn get pokemonId => integer().references(Pokemons, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {pokemonId};
}
