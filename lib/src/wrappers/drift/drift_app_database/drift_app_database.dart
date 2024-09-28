import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/presentation/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/migrations/drift_app_database_migrator.dart';

part 'drift_app_database.g.dart';

@DriftDatabase(
  tables: [
    PeriodDailyBudgetLocalEntity,
  ],
  queries: {
    "current_timestamp": "SELECT CURRENT_TIMESTAMP;",
  },
)
class DriftAppDatabase extends _$DriftAppDatabase {
  DriftAppDatabase(super.e);

  final DriftAppDatabaseMigrator _migrator = DriftAppDatabaseMigrator();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => _migrator.migrationStrategy;
}
