part of "set_month_daily_budget_controller.dart";

sealed class SetMonthDailyBudgetControllerStateData extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SetMonthDailyBudgetControllerStateDataNoBudgetsProvided
    extends SetMonthDailyBudgetControllerStateData {
  SetMonthDailyBudgetControllerStateDataNoBudgetsProvided();

  @override
  List<Object> get props => [];
}

class SetMonthDailyBudgetControllerStateDataSelections
    extends SetMonthDailyBudgetControllerStateData {
  SetMonthDailyBudgetControllerStateDataSelections({
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
