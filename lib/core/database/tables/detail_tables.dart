import 'package:drift/drift.dart';

// Detalle de cada Pokemon y de sus formas, una fila por id
// Los datos simples van en columnas
// Las listas se guardan como texto JSON porque siempre se leen completas
// y nunca se busca ni se filtra por ellas en la base
@DataClassName('PokemonDetailRow')
class PokemonDetails extends Table {
  IntColumn get pokemonId => integer()();
  TextColumn get nombre => text()();
  IntColumn get altura => integer()();
  IntColumn get peso => integer()();
  TextColumn get sprite => text().nullable()();
  TextColumn get artwork => text().nullable()();
  TextColumn get spriteShiny => text().nullable()();
  TextColumn get artworkShiny => text().nullable()();

  // listas en JSON
  TextColumn get tipos => text()();
  TextColumn get estadisticas => text()();
  TextColumn get habilidades => text()();
  TextColumn get movimientos => text()();
  TextColumn get gruposHuevo => text()();
  TextColumn get formas => text()();
  TextColumn get evoluciones => text()();

  // ultima vez que se guardo, para saber que tan reciente es
  DateTimeColumn get actualizadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {pokemonId};
}