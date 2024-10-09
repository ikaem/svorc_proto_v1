// import 'package:equatable/equatable.dart';
// import 'package:svorc_proto_v1/src/features/core/domain/values/home_screen_expenses_state_value.dart';
// import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen.dart';
// import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
// import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';

part of "home_cubit.dart";

sealed class HomeCubitState {}

class HomeCubitStateInitial extends HomeCubitState {}

// class HomeCubitStateCurrentDailyBudgetLoading extends HomeCubitState {}
class HomeCubitStateLoading extends HomeCubitState {}

class HomeCubitStateSuccess extends HomeCubitState {
  HomeCubitStateSuccess({
    required this.state,
  });

  final HomeScreenBalancesValue state;
}

class HomeCubitStateCurrentMonthDailyBudgetNotFound extends HomeCubitState {}

class HomeCubitStateFailure extends HomeCubitState {
  HomeCubitStateFailure({
    required this.errorMessage,
  });

  final String errorMessage;
}
