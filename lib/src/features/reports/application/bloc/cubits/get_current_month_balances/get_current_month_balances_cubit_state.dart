// import 'package:equatable/equatable.dart';
// import 'package:svorc_proto_v1/src/features/core/domain/values/home_screen_expenses_state_value.dart';
// import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen.dart';
// import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
// import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';

part of "get_current_month_balances_cubit.dart";

sealed class GetCurrentMonthBalancesCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCurrentMonthBalancesCubitStateInitial
    extends GetCurrentMonthBalancesCubitState {}

// class HomeScreenBalancesReportCubitStateCurrentDailyBudgetLoading extends HomeScreenBalancesReportCubitState {}
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

// class HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound
//     extends HomeScreenBalancesReportCubitState {}

class GetCurrentMonthBalancesCubitStateFailure
    extends GetCurrentMonthBalancesCubitState {
  GetCurrentMonthBalancesCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
