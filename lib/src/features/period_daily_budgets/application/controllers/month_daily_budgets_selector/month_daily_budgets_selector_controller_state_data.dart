part of "month_daily_budgets_selector_controller.dart";

class MonthDailyBudgetsSelectorControllerStateData extends Equatable {
  const MonthDailyBudgetsSelectorControllerStateData({
    required this.selectedBudget,
    required this.selectedYear,
    required this.years,
    required this.selectedYearBudgets,
  });

  final PeriodDailyBudgetModel selectedBudget;
  final int selectedYear;
  final List<int> years;
  final List<PeriodDailyBudgetModel> selectedYearBudgets;

  @override
  List<Object> get props => [
        selectedBudget,
        selectedYear,
        years,
        selectedYearBudgets,
      ];
}
