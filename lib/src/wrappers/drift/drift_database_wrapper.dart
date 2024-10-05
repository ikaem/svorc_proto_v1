import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/query_executors/sqlite_query_executor.dart';

class DriftDatabaseWrapper {
  DriftDatabaseWrapper(this._executor);

  final QueryExecutor _executor;

  factory DriftDatabaseWrapper.app() {
    return DriftDatabaseWrapper(SqliteQueryExecutor().executor);
  }

  DriftAppDatabase? _database;

  DriftAppDatabase get database {
    final initializedDatabase = _database;
    if (initializedDatabase == null) {
      throw Exception("Database not initialized");
    }

    return initializedDatabase;
  }

  // $Period get periodDailyBudgetsRepo => database.periodDail
  $PeriodDailyBudgetLocalEntityTable get periodDailyBudgetRepo =>
      database.periodDailyBudgetLocalEntity;
  $CategoryLocalEntityTable get categoryRepo => database.categoryLocalEntity;
  $ExpenseLocalEntityTable get expenseRepo => database.expenseLocalEntity;

  // Future<void> initialize() async {
  void initialize() {
    try {
      final database = DriftAppDatabase(_executor);

      // TODO because of this, we have to await the initialization of the database - lets remove it for now
      // final currentTime = await database.current_timestamp().get();
      // log("Current time: $currentTime");

      // final currentTime = await database.current_timestamp().get();
      _database = database;
    } catch (e) {
      log("Error initializing database: $e");
      rethrow;
    }
  }

  // TODO dont forget that drfit is supported by dev tools
  // https://drift.simonbinder.eu/docs/community_tools/#drift_db_viewer

  Future<T> runInTransaction<T>(
    Future<T> Function() action, {
    bool requireNew = false,
  }) async {
    return database.transaction(action, requireNew: requireNew);
  }

  Future runInBatch(
    void Function(Batch batch) action,
  ) async {
    await database.batch(action);
  }

  Future<void> close() async {
    await database.close();
  }
}
