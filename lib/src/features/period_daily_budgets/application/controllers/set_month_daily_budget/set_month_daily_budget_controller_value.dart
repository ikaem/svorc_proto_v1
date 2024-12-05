part of "set_month_daily_budget_controller.dart";

// TODO not sure this is good name for this class
// TODO move to values - or leave here?
class _SetMonthDailyBudgetControllerValue extends Equatable {
  const _SetMonthDailyBudgetControllerValue({
    required List<PeriodDailyBudgetModel> budgets,
  }) : _budgets = budgets;

  final List<PeriodDailyBudgetModel> _budgets;

  List<int> get years {
    return _budgets.map((e) => e.periodStart.year).toSet().toList()..sort();
  }

  PeriodDailyBudgetModel get thisMonthBudget {
    final DateTime now = DateTime.now();
    final PeriodExtremesMoments extremes =
        PeriodExtremesMomentsCalculator.calculateMonthMoments(
            monthIndex: now.month, year: now.year);

    final PeriodDailyBudgetModel budget =
        _budgets.firstWhere((b) => b.periodStart == extremes.periodStart);

    return budget;
  }

  List<PeriodDailyBudgetModel> getBudgetsForYear(int year) {
    return _budgets
        .where((element) => element.periodStart.year == year)
        .toList();
    // TODO this will need to be sorted
    // ..sort();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_budgets];
}
