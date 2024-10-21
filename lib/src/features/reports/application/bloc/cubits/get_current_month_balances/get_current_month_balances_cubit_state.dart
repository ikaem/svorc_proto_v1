part of "get_current_month_balances_cubit.dart";

sealed class GetCurrentMonthBalancesCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCurrentMonthBalancesCubitStateInitial
    extends GetCurrentMonthBalancesCubitState {}

class GetCurrentMonthBalancesCubitStateLoading
    extends GetCurrentMonthBalancesCubitState {}

class GetCurrentMonthBalancesCubitStateSuccess
    extends GetCurrentMonthBalancesCubitState {
  GetCurrentMonthBalancesCubitStateSuccess({
    required this.balances,
  });

  final MonthBalancesValue balances;

  @override
  List<Object?> get props => [balances];
}

class GetCurrentMonthBalancesCubitStateFailure
    extends GetCurrentMonthBalancesCubitState {
  GetCurrentMonthBalancesCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
