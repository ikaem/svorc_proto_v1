import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_home_screen_balances_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/home_screen_balances_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

part "home_screen_balances_report_cubit_state.dart";

// TODO: rename and remove logic to get month daily budget
class HomeScreenBalancesReportCubit
    extends Cubit<HomeScreenBalancesReportCubitState> {
  HomeScreenBalancesReportCubit({
    required GetHomeScreenBalancesUseCase getHomeScreenBalancesUseCase,
    // required GetMonthDailyBudgetUseCase getMonthDailyBudgetUseCase,
  })  : _getHomeScreenBalancesUseCase = getHomeScreenBalancesUseCase,
        // _getMonthDailyBudgetUseCase = getMonthDailyBudgetUseCase,
        super(HomeScreenBalancesReportCubitStateInitial());

  final GetHomeScreenBalancesUseCase _getHomeScreenBalancesUseCase;
  // final GetMonthDailyBudgetUseCase _getMonthDailyBudgetUseCase;

  Future<void> onLoadBalances({
    required PeriodDailyBudgetModel currentMonthDailyBudget,
  }) async {
    emit(HomeScreenBalancesReportCubitStateLoading());

    final DateTime nowDate = DateTime.now();

    try {
      // final PeriodDailyBudgetModel? currentMonthDailyBudget =
      //     await _getMonthDailyBudgetUseCase(
      //   date: nowDate,
      // );

      // if (currentMonthDailyBudget == null) {
      //   emit(
      //       HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound());
      //   return;
      // }

      final PeriodExtremesMoments currentMonthExtremes =
          PeriodExtremesMomentsCalculator.calculateMonthMoments(
        monthIndex: nowDate.month,
        year: nowDate.year,
      );

      final HomeScreenBalancesValue balances =
          await _getHomeScreenBalancesUseCase(
        currentMonthExtremes: currentMonthExtremes,
        currentMonthDailyBudget: currentMonthDailyBudget,
      );
      emit(HomeScreenBalancesReportCubitStateSuccess(
        balances: balances,
      ));
    } catch (e) {
      log(e.toString());
      emit(
        HomeScreenBalancesReportCubitStateFailure(
          errorMessage: "There was an issue loading data",
        ),
      );
      // return;
    }
  }
}
