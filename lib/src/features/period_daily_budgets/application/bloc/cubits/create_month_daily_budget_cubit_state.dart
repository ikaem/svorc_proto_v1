part of "create_month_daily_budget_cubit.dart";

sealed class CreateMonthDailyBudgetCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateMonthDailyBudgetCubitStateInitial
    extends CreateMonthDailyBudgetCubitState {}

class CreateMonthDailyBudgetCubitStateLoading
    extends CreateMonthDailyBudgetCubitState {}

class CreateMonthDailyBudgetCubitStateSuccess
    extends CreateMonthDailyBudgetCubitState {
  CreateMonthDailyBudgetCubitStateSuccess({
    required this.createdDailyBudgetId,
  });

  final int createdDailyBudgetId;

  @override
  List<Object?> get props => [createdDailyBudgetId];
}

class CreateMonthDailyBudgetCubitStateFailure
    extends CreateMonthDailyBudgetCubitState {
  CreateMonthDailyBudgetCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
