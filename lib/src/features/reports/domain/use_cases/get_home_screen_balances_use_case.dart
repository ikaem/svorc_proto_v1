import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/home_screen_balances_value.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';

// TODO this needs to be tested
class GetHomeScreenBalancesUseCase {
  const GetHomeScreenBalancesUseCase(this._expensesRepository);

  final ExpensesRepository _expensesRepository;

  Future<HomeScreenBalancesValue> call({
    required PeriodExtremesMoments currentMonthExtremes,
    required PeriodDailyBudgetModel currentMonthDailyBudget,
  }) async {
    final GetExpensesFilterValue filter = GetExpensesFilterValue(
      minDate: currentMonthExtremes.periodStart,
      maxDate: currentMonthExtremes.periodEnd,
    );
    final List<ExpenseModel> currentMonthExpenses =
        await _expensesRepository.getExpenses(filter: filter);

    final MonthBalanceCalculationHelper calculator =
        MonthBalanceCalculationHelper(
      monthExpenses: currentMonthExpenses,
      dailyBudget: currentMonthDailyBudget.amount,
      monthDate: currentMonthExtremes.periodStart,
    );

    final DateBalanceValue todayBalance = calculator.todayBalance;
    final WeekBalanceValue weekBalance = calculator.weekBalance;
    final MonthBalanceValue monthBalance = calculator.monthBalance;

    final HomeScreenBalancesValue balances = HomeScreenBalancesValue(
      thisMonthDailyBudget: currentMonthDailyBudget,
      thisWeekBalance: weekBalance,
      thisMonthBalance: monthBalance,
      todayBalance: todayBalance,
    );

    return balances;
  }
}
