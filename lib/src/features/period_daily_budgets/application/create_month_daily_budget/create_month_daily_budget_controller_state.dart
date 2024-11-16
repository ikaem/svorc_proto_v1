part of "create_month_daily_budget_controller.dart";

class CreateMonthDailyBudgetControllerState extends Equatable {
  const CreateMonthDailyBudgetControllerState({
    required this.createdDailyBudgetId,
  });

  final int createdDailyBudgetId;

  @override
  List<Object> get props => [createdDailyBudgetId];
}
