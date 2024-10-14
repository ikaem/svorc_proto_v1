import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/values/new_period_daily_budget_local_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

class CreateMonthDailyBudgetUseCase {
  const CreateMonthDailyBudgetUseCase(this._periodDailyBudgetsRepository);
  final PeriodDailyBudgetsRepository _periodDailyBudgetsRepository;

  Future<int> call({
    required PeriodExtremesMoments monthExtremes,
    required int amount,
  }) async {
    final NewPeriodDailyBudgetLocalValue newPeriodDailyBudgetValue =
        NewPeriodDailyBudgetLocalValue(
      periodStart: monthExtremes.periodStart,
      periodEnd: monthExtremes.periodEnd,
      amount: amount,
      period: Period.month,
    );

    final int id = await _periodDailyBudgetsRepository.createPeriodDailyBudget(
      newPeriodDailyBudget: newPeriodDailyBudgetValue,
    );

    return id;
  }
}
