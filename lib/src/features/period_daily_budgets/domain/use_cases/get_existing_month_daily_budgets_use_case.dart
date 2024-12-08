import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';

class GetExistingMonthDailyBudgetsUseCase {
  GetExistingMonthDailyBudgetsUseCase(this._periodDailyBudgetsRepository);

  final PeriodDailyBudgetsRepository _periodDailyBudgetsRepository;

  Future<List<PeriodDailyBudgetModel>> call() async {
    final List<PeriodDailyBudgetModel> existingMonthDailyBudgets =
        await _periodDailyBudgetsRepository.getPeriodDailyBudgetsByPeriod(
            period: Period.month);

    return existingMonthDailyBudgets;
  }
}

// TODO this is not tested - write tests for it!