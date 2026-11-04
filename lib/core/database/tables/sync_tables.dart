import 'package:drift/drift.dart';

// Estado de la sincronización por recurso
class SyncMetadata extends Table {
  TextColumn get resourceKey => text()();
  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  TextColumn get status => text()();
  IntColumn get nextOffset => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {resourceKey};
}
