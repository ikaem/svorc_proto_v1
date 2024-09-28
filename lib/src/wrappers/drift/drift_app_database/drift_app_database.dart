import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/migrations/drift_app_database_migrator.dart';

part 'drift_app_database.g.dart';

@DriftDatabase(
  tables: [],
  queries: {
    "current_timestamp": "SELECT CURRENT_TIMESTAMP;",
  },
)
class DriftAppDatabase extends _$DriftAppDatabase {
  DriftAppDatabase(super.e);

  final DriftAppDatabaseMigrator _migrator = DriftAppDatabaseMigrator();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => _migrator.migrationStrategy;
}
