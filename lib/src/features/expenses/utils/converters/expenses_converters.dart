import 'package:svorc_proto_v1/src/features/expenses/domain/values/expense_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/extensions/date_time_extensions.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

abstract class ExpensesConverters {
  static ExpenseLocalEntityValue toEntityValueFromEntityData({
    required ExpenseLocalEntityData entityData,
  }) {
    final ExpenseLocalEntityValue value = ExpenseLocalEntityValue(
      id: entityData.id,
      amount: entityData.amount,
      date: entityData.date.normalizedToSeconds,
      categoryId: entityData.categoryId,
      note: entityData.note,
    );

    return value;
  }
}
