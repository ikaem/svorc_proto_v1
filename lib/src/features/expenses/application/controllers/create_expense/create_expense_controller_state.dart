part of "create_expense_controller.dart";

class CreateExpenseControllerState extends Equatable {
  const CreateExpenseControllerState({
    required this.createdExpenseId,
  });

  final int? createdExpenseId;

  @override
  List<Object?> get props => [createdExpenseId];
}
