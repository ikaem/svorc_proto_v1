import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/data_sources/local/period_daily_budget_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/repositories/period_daily_budget_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/repositories/period_daily_budget_repository_impl.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/new_period_daily_budget_local_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/period_daily_budget_local_entity_value.dart';

void main() {
  final periodDailyBudgetLocalDataSource =
      _MockPeriodDailyBudgetLocalDataSource();

  // tested cass
  final repository = PeriodDailyBudgetRepositoryImpl(
    periodDailyBudgetLocalDataSource: periodDailyBudgetLocalDataSource,
  );

  setUpAll(
    () {
      registerFallbackValue(_FakeNewPeriodDailyBudgetLocalValue());
      registerFallbackValue(Period.day);
    },
  );

  tearDown(
    () {
      reset(periodDailyBudgetLocalDataSource);
    },
  );

  group(
    "$PeriodDailyBudgetRepository",
    () {
      group(
        "createPeriodDailyBudget",
        () {
          test(
            "given [NewPeriodDailyBudgetLocalValue] "
            "when [createPeriodDailyBudget] is called "
            "then should call [PeriodDailyBudgetLocalDataSource.createPeriodDailyBudget] with expected arguments and return expected id",
            () async {
              // setup
              when(
                () => periodDailyBudgetLocalDataSource.createPeriodDailyBudget(
                  newPeriodDailyBudget: any(named: "newPeriodDailyBudget"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              final localValue = NewPeriodDailyBudgetLocalValue(
                periodStart: DateTime.now(),
                periodEnd: DateTime.now(),
                amount: 100,
                period: Period.month,
              );

              // when
              final id = await repository.createPeriodDailyBudget(
                newPeriodDailyBudget: localValue,
              );

              // then
              verify(
                () => periodDailyBudgetLocalDataSource.createPeriodDailyBudget(
                  newPeriodDailyBudget: localValue,
                ),
              ).called(1);
              expect(id, equals(1));

              // cleanup
            },
          );
          // TODO test that it propagates error thrown by data source
        },
      );

      group(
        "updatePeriodDailyBudget",
        () {
          test(
            "given [amount]"
            "when [updatePeriodDailyBudget] is called "
            "then should call [PeriodDailyBudgetLocalDataSource.updatePeriodDailyBudget] with expected arguments and return expected id",
            () async {
              // setup
              when(
                () => periodDailyBudgetLocalDataSource.updatePeriodDailyBudget(
                  id: any(named: "id"),
                  amount: any(named: "amount"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const id = 1;
              const amount = 100;

              // when
              final updatedId = await repository.updatePeriodDailyBudget(
                id: id,
                amount: amount,
              );

              // then
              verify(
                () => periodDailyBudgetLocalDataSource.updatePeriodDailyBudget(
                  id: id,
                  amount: amount,
                ),
              ).called(1);
              expect(updatedId, equals(1));

              // cleanup
            },
          );
        },
      );

      group(
        'getPeriodDailyBudgetById',
        () {
          test(
            "given [id]"
            "when [getPeriodDailyBudgetById] is called "
            "then should call [PeriodDailyBudgetLocalDataSource.getPeriodDailyBudgetById] with expected arguments and return expected valuue",
            () async {
              // setup
              final entityValue = PeriodDailyBudgetLocalEntityValue(
                id: 1,
                periodStart: DateTime.now(),
                periodEnd: DateTime.now(),
                amount: 100,
                period: Period.month,
              );

              when(
                () => periodDailyBudgetLocalDataSource.getPeriodDailyBudgetById(
                  id: any(named: "id"),
                ),
              ).thenAnswer(
                (_) async => entityValue,
              );

              // given
              const id = 1;

              // when
              final entity = await repository.getPeriodDailyBudgetById(
                id: id,
              );

              // then
              final expectedModel = PeriodDailyBudgetModel(
                id: entityValue.id,
                periodStart: entityValue.periodStart,
                periodEnd: entityValue.periodEnd,
                amount: entityValue.amount,
                period: entityValue.period,
              );

              verify(
                () => periodDailyBudgetLocalDataSource.getPeriodDailyBudgetById(
                  id: id,
                ),
              ).called(1);
              expect(entity, equals(expectedModel));

              // cleanup
            },
          );
        },
      );

      group(
        'getPeriodDailyBudgetByDateAndPeriod',
        () {
          test(
            "given [date] and [period]"
            "when [getPeriodDailyBudgetByDateAndPeriod] is called "
            "then should call [PeriodDailyBudgetLocalDataSource.getPeriodDailyBudgetByDateAndPeriod] with expected arguments and return expected valuue",
            () async {
              // setup
              final entityValue = PeriodDailyBudgetLocalEntityValue(
                id: 1,
                periodStart: DateTime.now(),
                periodEnd: DateTime.now().add(const Duration(days: 1)),
                amount: 100,
                period: Period.month,
              );

              when(
                () => periodDailyBudgetLocalDataSource
                    .getPeriodDailyBudgetByDateAndPeriod(
                  date: any(named: "date"),
                  period: any(named: "period"),
                ),
              ).thenAnswer(
                (_) async => entityValue,
              );

              // given
              final dateTime = DateTime.now().add(const Duration(hours: 1));
              const period = Period.month;

              // when
              final entity =
                  await repository.getPeriodDailyBudgetByDateAndPeriod(
                date: dateTime,
                period: period,
              );

              // then
              final expectedModel = PeriodDailyBudgetModel(
                id: entityValue.id,
                periodStart: entityValue.periodStart,
                periodEnd: entityValue.periodEnd,
                amount: entityValue.amount,
                period: entityValue.period,
              );

              verify(
                () => periodDailyBudgetLocalDataSource
                    .getPeriodDailyBudgetByDateAndPeriod(
                  date: dateTime,
                  period: period,
                ),
              ).called(1);
              expect(entity, equals(expectedModel));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockPeriodDailyBudgetLocalDataSource extends Mock
    implements PeriodDailyBudgetLocalDataSource {}

class _FakeNewPeriodDailyBudgetLocalValue extends Fake
    implements NewPeriodDailyBudgetLocalValue {}
