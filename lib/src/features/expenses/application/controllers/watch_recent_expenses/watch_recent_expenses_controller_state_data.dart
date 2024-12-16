part of "watch_recent_expenses_controller.dart";

class WatchRecentExpensesControllerStateData extends Equatable {
  const WatchRecentExpensesControllerStateData({
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  List<Object> get props => [expenses];
}
