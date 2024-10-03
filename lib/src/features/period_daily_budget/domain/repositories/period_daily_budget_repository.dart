import 'package:svorc_proto_v1/src/features/period_daily_budget/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/new_period_daily_budget_local_value.dart';

abstract interface class PeriodDailyBudgetRepository {
  Future<int> createPeriodDailyBudget({
    required NewPeriodDailyBudgetLocalValue newPeriodDailyBudget,
  });

  Future<int> updatePeriodDailyBudget({
    // required PeriodDailyBudgetLocalEntityValue periodDailyBudget,
    required int amount,
    required int id,
  });

  Future<PeriodDailyBudgetModel?> getPeriodDailyBudgetByDateAndPeriod({
    required DateTime date,
    required Period period,
  });

  Future<PeriodDailyBudgetModel?> getPeriodDailyBudgetById({
    required int id,
  });
}
