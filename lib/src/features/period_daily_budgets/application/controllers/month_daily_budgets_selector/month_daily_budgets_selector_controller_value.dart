part of "month_daily_budgets_selector_controller.dart";

// TODO move to values - or leave here?
class _MonthDailyBudgetsSelectorControllerValue extends Equatable {
  const _MonthDailyBudgetsSelectorControllerValue({
    required List<PeriodDailyBudgetModel> budgets,
  }) : _budgets = budgets;

  final List<PeriodDailyBudgetModel> _budgets;

  List<int> get years =>
      _budgets.map((e) => e.periodStart.year).toSet().toList()..sort();

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
