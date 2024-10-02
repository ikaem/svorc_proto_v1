import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/new_period_daily_budget_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/period_daily_budget_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';

abstract interface class PeriodDailyBudgetLocalDataSource {
// store period daily budget
  Future<int> createPeriodDailyBudget({
    required NewPeriodDailyBudgetLocalEntityValue newPeriodDailyBudget,
  });

  // update period daily budget
  Future<int> updatePeriodDailyBudget({
    required PeriodDailyBudgetLocalEntityValue periodDailyBudget,
  });

// get period daily budget
  Future<PeriodDailyBudgetLocalEntityValue?>
      getPeriodDailyBudgetByDateAndPeriod({
    required DateTime date,
    required Period period,
  });

  Future<PeriodDailyBudgetLocalEntityValue?> getPeriodDailyBudgetById({
    required int id,
  });
}
