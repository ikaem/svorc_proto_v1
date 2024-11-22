part of "get_recent_expenses_controller.dart";

class GetRecentExpensesControllerStateData extends Equatable {
  const GetRecentExpensesControllerStateData({
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  List<Object> get props => [expenses];
}
