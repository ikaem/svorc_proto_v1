part of "get_existing_month_daily_budgets_controller.dart";

class GetExistingMonthDailyBudgetsControllerStateData extends Equatable {
  const GetExistingMonthDailyBudgetsControllerStateData({
    required this.existingMonthDailyBudgets,
  });

  final List<PeriodDailyBudgetModel> existingMonthDailyBudgets;

  @override
  List<Object> get props => [existingMonthDailyBudgets];
}
