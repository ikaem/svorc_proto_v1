import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_home_screen_balances_use_case.dart';

void main() {
  final PeriodDailyBudgetsRepository dailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  // tested class
  final GetMonthDailyBudgetUseCase useCase =
      GetMonthDailyBudgetUseCase(dailyBudgetsRepository);

  setUpAll(() {
    registerFallbackValue(Period.month);
  });

  tearDown(() {
    reset(dailyBudgetsRepository);
  });

  group(
    GetMonthDailyBudgetUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given [DateTime] "
            "when [call] is called "
            "then should call [PeriodDailyBudgetsRepository.getPeriodDailyBudgetByDateAndPeriod] with correct arguments and return expected result",
            () async {
              // setup
              final PeriodDailyBudgetModel expectedResult =
                  PeriodDailyBudgetModel(
                id: 1,
                amount: 1000,
                period: Period.month,
                periodEnd: DateTime.now().add(const Duration(days: 30)),
                periodStart: DateTime.now(),
              );
              when(
                () =>
                    dailyBudgetsRepository.getPeriodDailyBudgetByDateAndPeriod(
                  date: any(named: "date"),
                  period: any(named: "period"),
                ),
              ).thenAnswer(
                (_) async => expectedResult,
              );

              // given
              final DateTime date = DateTime.now();

              // when
              final PeriodDailyBudgetModel? result = await useCase(
                date: date,
              );

              // then
              expect(
                result,
                equals(expectedResult),
              );

              verify(
                () =>
                    dailyBudgetsRepository.getPeriodDailyBudgetByDateAndPeriod(
                  date: date,
                  period: Period.month,
                ),
              ).called(1);

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
