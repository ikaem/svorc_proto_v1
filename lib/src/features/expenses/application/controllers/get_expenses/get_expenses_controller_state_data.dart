part of "get_expenses_controller.dart";

class GetExpensesControllerStateData extends Equatable {
  const GetExpensesControllerStateData({
    required this.expenses,
  });

// TODO we will probably need some metadata eventually
  final List<ExpenseModel> expenses;

  @override
  List<Object> get props => [expenses];
}
