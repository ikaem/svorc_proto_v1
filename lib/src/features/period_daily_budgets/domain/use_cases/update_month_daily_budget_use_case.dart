import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';

class UpdateMonthDailyBudgetUseCase {
  const UpdateMonthDailyBudgetUseCase(this._periodDailyBudgetsRepository);

  final PeriodDailyBudgetsRepository _periodDailyBudgetsRepository;

  Future<int> call({
    required int amount,
    required int id,
  }) async {
    final int updatedId =
        await _periodDailyBudgetsRepository.updatePeriodDailyBudget(
      amount: amount,
      id: id,
    );

    return updatedId;
  }
}
