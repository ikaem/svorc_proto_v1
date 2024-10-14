import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/create_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/values/new_period_daily_budget_local_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

void main() {
  final PeriodDailyBudgetsRepository dailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  // tested class
  final CreateMonthDailyBudgetUseCase useCase =
      CreateMonthDailyBudgetUseCase(dailyBudgetsRepository);

  setUpAll(() {
    registerFallbackValue(_FakeNewPeriodDailyBudgetLocalValue());
  });

  tearDown(() {
    reset(dailyBudgetsRepository);
  });

  group(
    CreateMonthDailyBudgetUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given [PeriodExtremesMoments] and [int] "
            "when [call] is called "
            "then should call [PeriodDailyBudgetsRepository.createPeriodDailyBudget] with correct arguments and return expected result",
            () async {
              // setup
              const int expectedResult = 1;

              when(
                () => dailyBudgetsRepository.createPeriodDailyBudget(
                  newPeriodDailyBudget: any(named: "newPeriodDailyBudget"),
                ),
              ).thenAnswer(
                (_) async => expectedResult,
              );

              // given
              final PeriodExtremesMoments monthExtremes = PeriodExtremesMoments(
                periodStart: DateTime.now(),
                periodEnd: DateTime.now().add(
                  const Duration(days: 30),
                ),
                period: Period.month,
                periodIndex: 1,
                periodName: "January",
                year: 2022,
              );
              const int amount = 1000;

              // when
              final int result = await useCase(
                monthExtremes: monthExtremes,
                amount: amount,
              );

              // then
              final NewPeriodDailyBudgetLocalValue
                  expectedNewPeriodDailyBudget = NewPeriodDailyBudgetLocalValue(
                periodStart: monthExtremes.periodStart,
                periodEnd: monthExtremes.periodEnd,
                amount: amount,
                period: Period.month,
              );

              verify(
                () => dailyBudgetsRepository.createPeriodDailyBudget(
                  newPeriodDailyBudget: expectedNewPeriodDailyBudget,
                ),
              ).called(1);
              expect(
                result,
                equals(expectedResult),
              );

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockPeriodDailyBudgetsRepository extends Mock
    implements PeriodDailyBudgetsRepository {}

class _FakeNewPeriodDailyBudgetLocalValue extends Fake
    implements NewPeriodDailyBudgetLocalValue {}
