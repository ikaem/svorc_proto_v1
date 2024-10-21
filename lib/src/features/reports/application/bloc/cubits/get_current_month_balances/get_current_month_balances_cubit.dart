import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/month_balances_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

part "get_current_month_balances_cubit_state.dart";

// TODO: rename and remove logic to get month daily budget
class GetCurrentMonthBalancesCubit
    extends Cubit<GetCurrentMonthBalancesCubitState> {
  GetCurrentMonthBalancesCubit({
    required GetMonthBalancesUseCase getHomeScreenBalancesUseCase,
  })  : _getHomeScreenBalancesUseCase = getHomeScreenBalancesUseCase,
        super(GetCurrentMonthBalancesCubitStateInitial());

  final GetMonthBalancesUseCase _getHomeScreenBalancesUseCase;

  Future<void> onLoadBalances({
    required PeriodDailyBudgetModel currentMonthDailyBudget,
  }) async {
    emit(GetCurrentMonthBalancesCubitStateLoading());

    final DateTime nowDate = DateTime.now();

    try {
      final PeriodExtremesMoments currentMonthExtremes =
          PeriodExtremesMomentsCalculator.calculateMonthMoments(
        monthIndex: nowDate.month,
        year: nowDate.year,
      );

      final MonthBalancesValue balances = await _getHomeScreenBalancesUseCase(
        monthExtremes: currentMonthExtremes,
        monthDailyBudget: currentMonthDailyBudget,
      );
      emit(GetCurrentMonthBalancesCubitStateSuccess(
        balances: balances,
      ));
    } catch (e) {
      log(e.toString());
      emit(
        GetCurrentMonthBalancesCubitStateFailure(
          errorMessage: "There was an issue loading data",
        ),
      );
      // return;
    }
  }
}
