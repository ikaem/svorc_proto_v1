// TODO this needs testing too

import 'package:svorc_proto_v1/src/features/period_daily_budget/domain/values/period_daily_budget_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budget/utils/extensions/date_time_extensions.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

abstract class PeriodDailyBudgetConverters {
  static PeriodDailyBudgetLocalEntityValue toEntityValueFromEntityData({
    required PeriodDailyBudgetLocalEntityData entityData,
  }) {
    final PeriodDailyBudgetLocalEntityValue value =
        PeriodDailyBudgetLocalEntityValue(
      id: entityData.id,
      periodStart: entityData.periodStart.normalizedToSeconds,
      periodEnd: entityData.periodEnd.normalizedToSeconds,
      amount: entityData.amount,
      period: entityData.period,
    );

    return value;
  }
}
