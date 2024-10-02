import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/data_sources/local/period_daily_budget_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/new_period_daily_budget_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/period_daily_budget_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/utils/converters/period_daily_budget_converters.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_database_wrapper.dart';

class PeriodDailyBudgetLocalDataSourceImpl
    implements PeriodDailyBudgetLocalDataSource {
  PeriodDailyBudgetLocalDataSourceImpl({
    required DriftDatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;

  final DriftDatabaseWrapper _databaseWrapper;

// store period daily budget
  @override
  Future<int> createPeriodDailyBudget({
    required NewPeriodDailyBudgetLocalEntityValue newPeriodDailyBudget,
  }) async {
    final companion = PeriodDailyBudgetLocalEntityCompanion.insert(
      periodStart: newPeriodDailyBudget.periodStart,
      periodEnd: newPeriodDailyBudget.periodEnd,
      amount: newPeriodDailyBudget.amount,
      period: newPeriodDailyBudget.period,
    );

    // throw Exception('Not implemented yet');

    final id = await _databaseWrapper.database.periodDailyBudgetLocalEntity
        .insertOne(companion);

    return id;
  }

  // update period daily budget
  @override
  Future<int> updatePeriodDailyBudget({
    required PeriodDailyBudgetLocalEntityValue periodDailyBudget,
  }) async {
    // throw UnimplementedError();
    final companion = PeriodDailyBudgetLocalEntityCompanion(
      // only need amount to be updated
      amount: Value(periodDailyBudget.amount),
    );

    final update = _databaseWrapper.periodDailyBudgetRepo.update();
    final updateBudget = update
      ..where((tbl) => tbl.id.equals(periodDailyBudget.id));

    final id = await updateBudget.write(companion);
    return id;
  }

// get period daily budget
  @override
  Future<PeriodDailyBudgetLocalEntityValue?>
      getPeriodDailyBudgetByDateAndPeriod({
    required DateTime date,
    required Period period,
  }) async {
    // throw UnimplementedError();

    final select = _databaseWrapper.periodDailyBudgetRepo.select();
    final budgetSelect = select
      ..where((tbl) {
        final isWithinMoments = tbl.periodStart.isSmallerOrEqualValue(date) &
            tbl.periodEnd.isBiggerOrEqualValue(date);

        final isPeriod = tbl.period.equals(period.index);

        return isWithinMoments & isPeriod;
      });

    final entityData = await budgetSelect.getSingleOrNull();
    if (entityData == null) {
      return null;
    }

    final entityValue = PeriodDailyBudgetConverters.toEntityValueFromEntityData(
        entityData: entityData);

    return entityValue;
  }

  @override
  Future<PeriodDailyBudgetLocalEntityValue?> getPeriodDailyBudgetById({
    required int id,
  }) async {
    // throw UnimplementedError();
    final select = _databaseWrapper.periodDailyBudgetRepo.select();
    final budgetSelect = select..where((tbl) => tbl.id.equals(id));

    final entityData = await budgetSelect.getSingleOrNull();
    if (entityData == null) {
      return null;
    }

    final entityValue = PeriodDailyBudgetConverters.toEntityValueFromEntityData(
        entityData: entityData);

    return entityValue;
  }
}
