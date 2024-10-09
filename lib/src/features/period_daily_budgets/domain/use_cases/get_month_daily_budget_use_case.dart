import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';

class GetMonthDailyBudgetUseCase {
  const GetMonthDailyBudgetUseCase(this._periodDailyBudgetsRepository);

  final PeriodDailyBudgetsRepository _periodDailyBudgetsRepository;

  Future<PeriodDailyBudgetModel?> call({
    required DateTime date,
  }) async {
    final PeriodDailyBudgetModel? periodDailyBudget =
        await _periodDailyBudgetsRepository.getPeriodDailyBudgetByDateAndPeriod(
      date: date,
      period: Period.month,
    );

    return periodDailyBudget;
  }
}
