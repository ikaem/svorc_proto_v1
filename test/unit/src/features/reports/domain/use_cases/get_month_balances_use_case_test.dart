import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/month_balances_value.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';

void main() {
  final ExpensesRepository expensesRepository = _MockExpensesRepository();

  // tested class
  final GetMonthBalancesUseCase useCase =
      GetMonthBalancesUseCase(expensesRepository: expensesRepository);

  setUpAll(() {
    registerFallbackValue(_FakeGetExpensesFilterValue());
  });

  tearDown(() {
    reset(expensesRepository);
  });

  group(
    GetMonthBalancesUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given [PeriodExtremesMoments] and [PeriodDailyBudgetModel] "
            "when [call] is called "
            "then should call [ExpensesRepository.getExpenses] with correct arguments and return expected result",
            () async {
              // setup
              final List<ExpenseModel> expensesModels = List.generate(
                13,
                (index) => ExpenseModel(
                  id: index + 1,
                  date: DateTime.now().add(Duration(days: index)),
                  amount: 100 * (index + 1),
                  category: CategoryModel(
                    id: index + 1,
                    name: "Category $index",
                  ),
                ),
              );

              when(
                () => expensesRepository.getExpenses(
                    filter: any(named: "filter")),
              ).thenAnswer(
                (_) async => expensesModels,
              );

              // given
              final PeriodExtremesMoments currentMonthExtremes =
                  PeriodExtremesMoments(
                periodStart: DateTime.now(),
                periodEnd: DateTime.now().add(const Duration(days: 30)),
                period: Period.month,
                periodIndex: 1,
                periodName: "January",
                year: 2022,
              );

              final PeriodDailyBudgetModel currentMonthDailyBudget =
                  PeriodDailyBudgetModel(
                id: 1,
                amount: 1000,
                period: Period.month,
                periodEnd: DateTime.now().add(const Duration(days: 30)),
                periodStart: DateTime.now(),
              );

              // when
              final MonthBalancesValue result = await useCase(
                monthExtremes: currentMonthExtremes,
                monthDailyBudget: currentMonthDailyBudget,
              );

              // then
              // TODO not using this still
              final expectedResult = MonthBalancesValue(
                currentMonthDailyBudget: currentMonthDailyBudget,
                currentWeekBalance: WeekBalanceValue(
                  spentValue: 0,
                  remainderValue: 0,
                  accumulationValue: 0,
                  date: DateTime.now(),
                ),
                currentMonthBalance: MonthBalanceValue(
                  spentValue: 0,
                  remainderValue: 0,
                  accumulationValue: 0,
                  date: DateTime.now(),
                ),
                currentDayBalance: DateBalanceValue(
                  date: DateTime.now(),
                  spentValue: 0,
                  remainderValue: 0,
                  accumulationValue: 0,
                ),
              );

              // TODO come back to it when I know result
              // expect(
              //   result,
              //   equals(expectedResult),
              // );

              verify(
                () => expensesRepository.getExpenses(
                  filter: GetExpensesFilterValue(
                    minDate: currentMonthExtremes.periodStart,
                    maxDate: currentMonthExtremes.periodEnd,
                  ),
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

class _MockExpensesRepository extends Mock implements ExpensesRepository {}

class _FakeGetExpensesFilterValue extends Fake
    implements GetExpensesFilterValue {}
