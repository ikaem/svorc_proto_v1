import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/month_balances_value.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "get_current_month_balances_controller_state_data.dart";
part "get_current_month_balances_controller.g.dart";

@riverpod
class GetCurrentMonthBalancesController
    extends _$GetCurrentMonthBalancesController {
  final ExpensesRepository _expensesRepository =
      GetItWrapper.get<ExpensesRepository>();

  late final GetMonthBalancesUseCase _getMonthBalancesUseCase =
      GetMonthBalancesUseCase(
    expensesRepository: _expensesRepository,
  );

  @override
  Future<GetCurrentMonthBalancesControllerStateData> build(
      PeriodDailyBudgetModel currentMonthDailyBudget) async {
    try {
      final GetCurrentMonthBalancesControllerStateData controllerStateData =
          await _loadBalances();

      return controllerStateData;
    } catch (e) {
      log("Error loading month daily budget: $e");
      // rethrowing so that the error state is produced by the controller
      rethrow;
    }
  }

  Future<void> onLoadBalances() async {
    state =
        const AsyncValue<GetCurrentMonthBalancesControllerStateData>.loading();

    try {
      final GetCurrentMonthBalancesControllerStateData controllerStateData =
          await _loadBalances();
      state = AsyncValue<GetCurrentMonthBalancesControllerStateData>.data(
        controllerStateData,
      );
    } catch (e) {
      log("Error loading month daily budget: $e");
      state = AsyncValue<GetCurrentMonthBalancesControllerStateData>.error(
        e,
        // making .current to match .build() rethrow state signature
        StackTrace.current,
      );
    }
  }

  Future<GetCurrentMonthBalancesControllerStateData> _loadBalances() async {
    final DateTime nowDate = DateTime.now();
    final PeriodExtremesMoments currentMonthExtremes =
        PeriodExtremesMomentsCalculator.calculateMonthMoments(
      monthIndex: nowDate.month,
      year: nowDate.year,
    );

    final MonthBalancesValue balances = await _getMonthBalancesUseCase(
      monthExtremes: currentMonthExtremes,
      monthDailyBudget: currentMonthDailyBudget,
    );

    return GetCurrentMonthBalancesControllerStateData(
      balances: balances,
    );
  }
}
