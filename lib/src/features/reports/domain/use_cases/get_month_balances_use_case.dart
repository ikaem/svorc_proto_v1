import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/month_balances_value.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';

// TODO this needs to be tested
class GetMonthBalancesUseCase {
  const GetMonthBalancesUseCase(this._expensesRepository);

  final ExpensesRepository _expensesRepository;

  Future<MonthBalancesValue> call({
    required PeriodExtremesMoments monthExtremes,
    required PeriodDailyBudgetModel monthDailyBudget,
  }) async {
    final GetExpensesFilterValue filter = GetExpensesFilterValue(
      minDate: monthExtremes.periodStart,
      maxDate: monthExtremes.periodEnd,
    );
    final List<ExpenseModel> monthExpenses =
        await _expensesRepository.getExpenses(filter: filter);

    final MonthBalanceCalculationHelper calculator =
        MonthBalanceCalculationHelper(
      monthExpenses: monthExpenses,
      dailyBudget: monthDailyBudget.amount,
      monthDate: monthExtremes.periodStart,
    );

    final DateBalanceValue currentDayBalance = calculator.todayBalance;
    final WeekBalanceValue currentWeekBalance = calculator.weekBalance;
    final MonthBalanceValue currentMonthBalance = calculator.monthBalance;

    final MonthBalancesValue balances = MonthBalancesValue(
      currentMonthDailyBudget: monthDailyBudget,
      currentWeekBalance: currentWeekBalance,
      currentMonthBalance: currentMonthBalance,
      currentDayBalance: currentDayBalance,
    );

    return balances;
  }
}
