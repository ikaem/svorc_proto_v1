part of "set_month_daily_budget_controller.dart";

class SetMonthDailyBudgetControllerStateData extends Equatable {
  const SetMonthDailyBudgetControllerStateData({
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
