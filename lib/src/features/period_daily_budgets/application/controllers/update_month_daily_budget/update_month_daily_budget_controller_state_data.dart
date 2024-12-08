part of "update_month_daily_budget_controller.dart";

class UpdateMonthDailyBudgetControllerStateData extends Equatable {
  const UpdateMonthDailyBudgetControllerStateData({
    required this.updatedDailyBudgetId,
  });

  final int updatedDailyBudgetId;

  @override
  List<Object> get props => [updatedDailyBudgetId];
}
