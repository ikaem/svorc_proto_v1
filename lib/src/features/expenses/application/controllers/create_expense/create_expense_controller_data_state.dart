part of "create_expense_controller.dart";

class CreateExpenseControllerDataState extends Equatable {
  const CreateExpenseControllerDataState({
    required this.createdExpenseId,
  });

  final int createdExpenseId;

  @override
  List<Object?> get props => [createdExpenseId];
}
