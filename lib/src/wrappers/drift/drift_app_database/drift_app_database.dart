import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/features/categories/data/entities/local/category/category_local_entity.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/entities/local/expense/expense_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/migrations/drift_app_database_migrator.dart';

part 'drift_app_database.g.dart';

@DriftDatabase(
  tables: [
    PeriodDailyBudgetLocalEntity,
    CategoryLocalEntity,
    ExpenseLocalEntity,
  ],
  queries: {
    "current_timestamp": "SELECT CURRENT_TIMESTAMP;",
  },
)
class DriftAppDatabase extends _$DriftAppDatabase {
  DriftAppDatabase(super.e);

  late final DriftAppDatabaseMigrator _migrator =
      DriftAppDatabaseMigrator(this);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return _migrator.migrationStrategy;
  }
}
