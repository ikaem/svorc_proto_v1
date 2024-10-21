part of 'get_recent_expenses_cubit.dart';

sealed class GetRecentExpensesCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRecentExpensesCubitStateInitial extends GetRecentExpensesCubitState {}

class GetRecentExpensesCubitStateLoading extends GetRecentExpensesCubitState {}

class GetRecentExpensesCubitStateSuccess extends GetRecentExpensesCubitState {
  GetRecentExpensesCubitStateSuccess({
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  List<Object?> get props => [expenses];
}

class GetRecentExpensesCubitStateFailure extends GetRecentExpensesCubitState {
  GetRecentExpensesCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
