import 'package:drift/drift.dart';

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
  );
}
