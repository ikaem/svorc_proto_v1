import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_existing_month_daily_budgets_use_case.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "get_existing_month_daily_budgets_controller_state_data.dart";
part "get_existing_month_daily_budgets_controller.g.dart";

@riverpod
class GetExistingMonthDailyBudgetsController
    extends _$GetExistingMonthDailyBudgetsController {
  final PeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      GetItWrapper.get<PeriodDailyBudgetsRepository>();

  late final GetExistingMonthDailyBudgetsUseCase
      _getExistingMonthDailyBudgetsUseCase =
      GetExistingMonthDailyBudgetsUseCase(
    periodDailyBudgetsRepository,
  );

  @override
  Future<GetExistingMonthDailyBudgetsControllerStateData> build() async {
    try {
      final GetExistingMonthDailyBudgetsControllerStateData
          controllerStateData = await _loadBudgets();
      return controllerStateData;
    } catch (e) {
      log("Error loading existing month daily budgets: $e");
      rethrow;
    }
  }

  Future<void> onLoadBudgets() async {
    state = const AsyncValue<
        GetExistingMonthDailyBudgetsControllerStateData>.loading();

    try {
      final GetExistingMonthDailyBudgetsControllerStateData
          controllerStateData = await _loadBudgets();
      state = AsyncValue<GetExistingMonthDailyBudgetsControllerStateData>.data(
        controllerStateData,
      );
    } catch (e) {
      log("Error loading existing month daily budgets: $e");
      state = AsyncValue<GetExistingMonthDailyBudgetsControllerStateData>.error(
        e,
        // making .current to match .build() rethrow state signature
        StackTrace.current,
      );
    }
  }

  Future<GetExistingMonthDailyBudgetsControllerStateData> _loadBudgets() async {
    final List<PeriodDailyBudgetModel> budgets =
        await _getExistingMonthDailyBudgetsUseCase();

    final GetExistingMonthDailyBudgetsControllerStateData controllerStateData =
        GetExistingMonthDailyBudgetsControllerStateData(
      existingMonthDailyBudgets: budgets,
    );

    return controllerStateData;
  }
}
