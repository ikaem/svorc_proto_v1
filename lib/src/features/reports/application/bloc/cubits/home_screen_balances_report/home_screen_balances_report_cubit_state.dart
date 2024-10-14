// import 'package:equatable/equatable.dart';
// import 'package:svorc_proto_v1/src/features/core/domain/values/home_screen_expenses_state_value.dart';
// import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen.dart';
// import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
// import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';

part of "home_screen_balances_report_cubit.dart";

sealed class HomeScreenBalancesReportCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeScreenBalancesReportCubitStateInitial
    extends HomeScreenBalancesReportCubitState {}

// class HomeScreenBalancesReportCubitStateCurrentDailyBudgetLoading extends HomeScreenBalancesReportCubitState {}
class HomeScreenBalancesReportCubitStateLoading
    extends HomeScreenBalancesReportCubitState {}

class HomeScreenBalancesReportCubitStateSuccess
    extends HomeScreenBalancesReportCubitState {
  HomeScreenBalancesReportCubitStateSuccess({
    required this.balances,
  });

  final HomeScreenBalancesValue balances;

  @override
  List<Object?> get props => [balances];
}

class HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound
    extends HomeScreenBalancesReportCubitState {}

class HomeScreenBalancesReportCubitStateFailure
    extends HomeScreenBalancesReportCubitState {
  HomeScreenBalancesReportCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
