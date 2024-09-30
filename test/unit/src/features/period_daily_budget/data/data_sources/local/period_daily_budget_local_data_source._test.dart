import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/data_sources/local/period_daily_budget_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/data_sources/local/period_daily_budget_local_data_source_impl.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/new_period_daily_budget_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/period_daily_budget_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/utils/converters/period_daily_budget_converters.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/utils/extensions/date_time_extensions.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

import '../../../../../../../utils/database/test_database_wrapper.dart';

void main() {
  late final TestDatabaseWrapper testDatabaseWrapper;
  late final PeriodDailyBudgetLocalDataSource periodDailyBudgetLocalDataSource;

  setUp(() {
    testDatabaseWrapper =
        TestDatabaseWrapper.getInitializedTestDatabaseWrapper();

    periodDailyBudgetLocalDataSource = PeriodDailyBudgetLocalDataSourceImpl(
      databaseWrapper: testDatabaseWrapper.databaseWrapper,
    );
  });

  tearDown(() {
    testDatabaseWrapper.databaseWrapper.close();
  });

  group(
    "$PeriodDailyBudgetLocalDataSource",
    () {
      group(
        "getPeriodDailyBudgetByDateAndPeriod",
        () {
          // dont return period daily budget for given date and period

          // return period daily budget for given date and period
          test(
            "given <pre-condition to the test>"
            "when <behavior we are specifying>"
            "then should <state we expect to happen>",
            () async {
              // setup

              // given

              // when

              // then

              // cleanup
            },
          );
        },
      );

      group(
        ".updatePeriodDailyBudget",
        () {
          test(
            "given existing [PeriodDailyBudgetLocalEntity]"
            "when [.updatePeriodDailyBudget] is called with new value"
            "then should update existing [PeriodDailyBudgetLocalEntity] in database",
            () async {
              final periodStart = DateTime.now();
              final periodEnd = DateTime.now().add(const Duration(
                days: 30,
              ));

              final value = NewPeriodDailyBudgetLocalEntityValue(
                amount: 100,
                period: Period.month,
                periodStart: periodStart,
                periodEnd: periodEnd,
              );
              final companion = PeriodDailyBudgetLocalEntityCompanion.insert(
                periodStart: periodStart,
                periodEnd: periodEnd,
                amount: 100,
                period: Period.month,
              );

              // given
              final id = await testDatabaseWrapper
                  .databaseWrapper.periodDailyBudgetRepo
                  .insertOne(companion);

              // when
              final updatedValue = PeriodDailyBudgetLocalEntityValue(
                id: id,
                periodStart: value.periodStart,
                periodEnd: value.periodEnd,
                amount: 200,
                period: value.period,
              );

              await periodDailyBudgetLocalDataSource.updatePeriodDailyBudget(
                periodDailyBudget: updatedValue,
              );

              // then
              final select = testDatabaseWrapper
                  .databaseWrapper.periodDailyBudgetRepo
                  .select();
              final budgetSelect = select..where((tbl) => tbl.id.equals(id));

              final entityData = await budgetSelect.getSingle();
              final entityValue =
                  PeriodDailyBudgetConverters.toEntityValueFromEntityData(
                      entityData: entityData);

              final expectedEntityValue = PeriodDailyBudgetLocalEntityValue(
                id: id,
                periodStart: periodStart.normalizedToSeconds,
                periodEnd: periodEnd.normalizedToSeconds,
                amount: 200,
                period: Period.month,
              );

              expect(entityValue, expectedEntityValue);

              // cleanup
            },
          );
        },
      );

      group(
        ".createPeriodDailyBudget",
        () {
          // given new value, it will store it
          test(
            "given [NewPeriodDailyBudgetLocalEntityValue]"
            "when [.createPeriodDailyBudget] is called"
            "then should add new [PeriodDailyBudgetLocalEntity] to database",
            () async {
              // setup
              final periodStart = DateTime.now();
              final periodEnd = DateTime.now().add(const Duration(
                days: 30,
              ));

              // given
              final value = NewPeriodDailyBudgetLocalEntityValue(
                amount: 100,
                period: Period.month,
                periodStart: periodStart,
                periodEnd: periodEnd,
              );

              // when
              final id = await periodDailyBudgetLocalDataSource
                  .createPeriodDailyBudget(
                newPeriodDailyBudget: value,
              );

              // then
              final select = testDatabaseWrapper
                  .databaseWrapper.periodDailyBudgetRepo
                  .select();
              final budgetSelect = select..where((tbl) => tbl.id.equals(id));

              final entityData = await budgetSelect.getSingle();
              final entityValue =
                  PeriodDailyBudgetConverters.toEntityValueFromEntityData(
                      entityData: entityData);

              final expectedEntityValue = PeriodDailyBudgetLocalEntityValue(
                id: id,
                periodStart: periodStart.normalizedToSeconds,
                periodEnd: periodEnd.normalizedToSeconds,
                amount: 100,
                period: Period.month,
              );

              expect(entityValue, expectedEntityValue);

              // cleanup
            },
          );

          // given new value with same date time periods as existing, it will throw error
          test(
            "given existing [PeriodDailyBudgetLocalEntity]"
            "when [.createPeriodDailyBudget] is called with same [periodStart] and [periodEnd]"
            "then should throw error",
            () async {
              // setup
              final periodStart = DateTime.now();
              final periodEnd = DateTime.now().add(const Duration(
                days: 30,
              ));

              final value = NewPeriodDailyBudgetLocalEntityValue(
                amount: 100,
                period: Period.month,
                periodStart: periodStart,
                periodEnd: periodEnd,
              );
              final companion = PeriodDailyBudgetLocalEntityCompanion.insert(
                periodStart: periodStart,
                periodEnd: periodEnd,
                amount: 100,
                period: Period.month,
              );

              // given
              await testDatabaseWrapper.databaseWrapper.periodDailyBudgetRepo
                  .insertOne(companion);

              // when / then
              // TODO used from here https://stackoverflow.com/a/71306212/9661910
              expect(
                () => periodDailyBudgetLocalDataSource.createPeriodDailyBudget(
                  newPeriodDailyBudget: value,
                ),
                throwsA(
                  predicate<SqliteException>(
                    (exception) {
                      return exception.message ==
                          'UNIQUE constraint failed: period_daily_budget_local_entity.period_start, period_daily_budget_local_entity.period_end';
                    },
                  ),
                ),
              );

              // cleanup
            },
          );
        },
      );
    },
  );
}
