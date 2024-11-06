part of "get_month_daily_budget_controller.dart";

class GetMonthDailyBudgetControllerState extends Equatable {
  const GetMonthDailyBudgetControllerState(
    this.dailyBudget,
  );

  final PeriodDailyBudgetModel? dailyBudget;

  @override
  List<Object?> get props => [dailyBudget];
}
