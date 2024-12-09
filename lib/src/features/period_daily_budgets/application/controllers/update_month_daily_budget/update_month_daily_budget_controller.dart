import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/update_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "update_month_daily_budget_controller_state_data.dart";
part "update_month_daily_budget_controller.g.dart";

@riverpod
class UpdateMonthDailyBudgetController
    extends _$UpdateMonthDailyBudgetController {
  final PeriodDailyBudgetsRepository _periodDailyBudgetsRepository =
      GetItWrapper.get<PeriodDailyBudgetsRepository>();

  late final UpdateMonthDailyBudgetUseCase _updateMonthDailyBudgetUseCase =
      UpdateMonthDailyBudgetUseCase(
    _periodDailyBudgetsRepository,
  );

  @override
  AsyncValue<UpdateMonthDailyBudgetControllerStateData?> build() {
    return const AsyncValue<UpdateMonthDailyBudgetControllerStateData?>.data(
      null,
    );
  }

  Future<void> onUpdateBudget({
    required int amount,
    required int id,
  }) async {
    state =
        const AsyncValue<UpdateMonthDailyBudgetControllerStateData?>.loading();

    try {
      final int updatedId = await _updateMonthDailyBudgetUseCase(
        amount: amount,
        id: id,
      );

      state = AsyncValue<UpdateMonthDailyBudgetControllerStateData?>.data(
        UpdateMonthDailyBudgetControllerStateData(
            updatedDailyBudgetId: updatedId),
      );
    } catch (e) {
      state = AsyncValue<UpdateMonthDailyBudgetControllerStateData?>.error(
        e,
        StackTrace.current,
      );
    }
  }
}
