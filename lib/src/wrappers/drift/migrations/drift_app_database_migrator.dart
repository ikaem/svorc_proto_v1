import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/migrations/schema_versions/schema_versions.dart';

class DriftAppDatabaseMigrator {
  final MigrationStrategy migrationStrategy = MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      // SOME POPULATE THINGS IF NEEDED
    },
    // TODO this will be generated for us
    // onUpgrade: (m, from, to) async {
    //   // SOME MIGRATIONS IF NEEDED
    // },
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.periodDailyBudgetLocalEntity);
      },
    ),
  );
}
