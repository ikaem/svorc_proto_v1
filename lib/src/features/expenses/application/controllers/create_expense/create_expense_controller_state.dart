part of "create_expense_controller.dart";

class CreateExpenseControllerState extends Equatable {
  const CreateExpenseControllerState({
    required this.createdExpenseId,
  });

// TODO ths doesnt need to be nullable if we make the state in the calendar nullable - which we probably shsould be cause initially controller has not state
  final int? createdExpenseId;

  @override
  List<Object?> get props => [createdExpenseId];
}
