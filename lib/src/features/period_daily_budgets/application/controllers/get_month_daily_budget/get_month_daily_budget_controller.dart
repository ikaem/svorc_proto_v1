// lets return empty data if not found

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "get_month_daily_budget_controller_state.dart";
part "get_month_daily_budget_controller.g.dart";

@riverpod
class GetMonthDailyBudgetController extends _$GetMonthDailyBudgetController {
  final PeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      GetItWrapper.get<PeriodDailyBudgetsRepository>();

  late final GetMonthDailyBudgetUseCase _getMonthDailyBudgetUseCase =
      GetMonthDailyBudgetUseCase(
    periodDailyBudgetsRepository,
  );

  @override
  Future<GetMonthDailyBudgetControllerState> build(DateTime date) async {
    // TODO check if anything needs to be disposed of

    try {
      final controllerState = await _loadBudget();
      // throw UnimplementedError();
      return controllerState;
    } catch (e) {
      log("Error loading month daily budget: $e");
      // rethrowing so that the error state is produced by the controller
      rethrow;
    }
  }

  Future<void> onLoadBudget() async {
    state = const AsyncValue<GetMonthDailyBudgetControllerState>.loading();

    try {
      final controllerState = await _loadBudget();
      state =
          AsyncValue<GetMonthDailyBudgetControllerState>.data(controllerState);
    } catch (e) {
      log("Error loading month daily budget: $e");
      state = AsyncValue<GetMonthDailyBudgetControllerState>.error(
        e,
        // making .current to match .build() rethrow state signature
        StackTrace.current,
      );
    }
  }

  Future<GetMonthDailyBudgetControllerState> _loadBudget() async {
    final PeriodDailyBudgetModel? monthDailyBudget =
        await _getMonthDailyBudgetUseCase(
      date: date,
    );

    final GetMonthDailyBudgetControllerState controllerState =
        GetMonthDailyBudgetControllerState(monthDailyBudget);

    return controllerState;
  }
}
