import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/create_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "create_month_daily_budget_controller_state.dart";
part "create_month_daily_budget_controller.g.dart";

@riverpod
class CreateMonthDailyBudgetController
    extends _$CreateMonthDailyBudgetController {
  final PeriodDailyBudgetsRepository _periodDailyBudgetsRepository =
      GetItWrapper.get<PeriodDailyBudgetsRepository>();

  late final CreateMonthDailyBudgetUseCase _createMonthDailyBudgetUseCase =
      CreateMonthDailyBudgetUseCase(
    _periodDailyBudgetsRepository,
  );

// TOOO testing if this could be used as nullabl state instead of nulalble value in state
  @override
  AsyncValue<CreateMonthDailyBudgetControllerState?> build() {
    return const AsyncValue<CreateMonthDailyBudgetControllerState?>.data(
      null,
    );
  }

  Future<void> onCreateBudget({
    required DateTime date,
    required int amount,
  }) async {
    state = const AsyncValue<CreateMonthDailyBudgetControllerState?>.loading();

    final PeriodExtremesMoments monthExtremes =
        PeriodExtremesMomentsCalculator.calculateMonthMoments(
      monthIndex: date.month,
      year: date.year,
    );

    try {
      final int id = await _createMonthDailyBudgetUseCase(
        monthExtremes: monthExtremes,
        amount: amount,
      );

      state = AsyncValue<CreateMonthDailyBudgetControllerState?>.data(
        CreateMonthDailyBudgetControllerState(createdDailyBudgetId: id),
      );
    } catch (e) {
      // TODO should be logging erros here - to it in all controlelrs s
      state = AsyncValue<CreateMonthDailyBudgetControllerState?>.error(
        e,
        StackTrace.current,
      );
    }
  }
}
