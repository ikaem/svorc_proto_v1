import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/migrations/schema_versions/schema_versions.dart';

class DriftAppDatabaseMigrator {
  // final QueryExecutor _executor;

  DriftAppDatabaseMigrator(this._database);

  final DriftAppDatabase _database;

  late final MigrationStrategy migrationStrategy = MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: _onBeforeOpen,
    // beforeOpen: (details) async {
    //   // SOME POPULATE THINGS IF NEEDED
    //   // _database

    //   final generalCategoryCompanion = CategoryLocalEntityCompanion.insert(
    //     name: "general",
    //   );

    //   // await _database
    //   //     .into(_database.categoryLocalEntity)
    //   //     .insertOnConflictUpdate(
    //   //       generalCategoryCompanion,
    //   //     );

    //   await _database.categoryLocalEntity.insertOne(
    //     generalCategoryCompanion,
    //     onConflict: DoNothing(),
    //   );
    // },
    // TODO this will be generated for us
    // onUpgrade: (m, from, to) async {
    //   // SOME MIGRATIONS IF NEEDED
    // },
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.periodDailyBudgetLocalEntity);
      },
      from2To3: (m, schema) async {
        await m.createTable(schema.categoryLocalEntity);
      },
      from3To4: (m, schema) async {
        await m.createTable(schema.expenseLocalEntity);
      },
    ),
  );

  Future<void> _onBeforeOpen(OpeningDetails details) async {
    // SOME POPULATE THINGS IF NEEDED
    // _database

    final generalCategoryCompanion = CategoryLocalEntityCompanion.insert(
      name: "general",
    );

    // await _database
    //     .into(_database.categoryLocalEntity)
    //     .insertOnConflictUpdate(
    //       generalCategoryCompanion,
    //     );

    await _database.categoryLocalEntity.insertOne(
      generalCategoryCompanion,
      onConflict: DoNothing(),
    );
  }
}
