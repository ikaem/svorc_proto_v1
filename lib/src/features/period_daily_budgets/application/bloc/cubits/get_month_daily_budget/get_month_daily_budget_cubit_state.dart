part of "get_month_daily_budget_cubit.dart";

sealed class GetMonthDailyBudgetCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMonthDailyBudgetCubitStateInitial
    extends GetMonthDailyBudgetCubitState {}

class GetMonthDailyBudgetCubitStateLoading
    extends GetMonthDailyBudgetCubitState {}

class GetMonthDailyBudgetCubitStateSuccess
    extends GetMonthDailyBudgetCubitState {
  GetMonthDailyBudgetCubitStateSuccess({
    required this.dailyBudget,
  });

  final PeriodDailyBudgetModel dailyBudget;

  @override
  List<Object?> get props => [dailyBudget];
}

class GetMonthDailyBudgetCubitStateMonthDailyBudgetNotFound
    extends GetMonthDailyBudgetCubitState {}

class GetMonthDailyBudgetCubitStateFailure
    extends GetMonthDailyBudgetCubitState {
  GetMonthDailyBudgetCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
