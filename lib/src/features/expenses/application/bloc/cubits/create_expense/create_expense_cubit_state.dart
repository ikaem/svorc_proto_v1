part of 'create_expense_cubit.dart';

sealed class CreateExpenseCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateExpenseCubitStateInitial extends CreateExpenseCubitState {}

class CreateExpenseCubitStateLoading extends CreateExpenseCubitState {}

class CreateExpenseCubitStateSuccess extends CreateExpenseCubitState {
  CreateExpenseCubitStateSuccess({
    required this.createdExpenseId,
  });

  final int createdExpenseId;

  @override
  List<Object?> get props => [createdExpenseId];
}

class CreateExpenseCubitStateFailure extends CreateExpenseCubitState {
  CreateExpenseCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
