import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/expense_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/extensions/date_time_extensions.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

abstract class ExpensesConverters {
  static ExpenseLocalEntityValue toEntityValueFromEntityData({
    required ExpenseLocalEntityData expenseEntityData,
    required CategoryLocalEntityData categoryEntityData,
  }) {
    final ExpenseLocalEntityValue value = ExpenseLocalEntityValue(
      id: expenseEntityData.id,
      amount: expenseEntityData.amount,
      date: expenseEntityData.date.normalizedToSeconds,
      // categoryId: entityData.categoryId,
      category: CategoryLocalEntityValue(
        id: categoryEntityData.id,
        name: categoryEntityData.name,
      ),
      note: expenseEntityData.note,
    );

    return value;
  }

  static ExpenseModel toModelFromEntityValue({
    required ExpenseLocalEntityValue entityValue,
  }) {
    final ExpenseModel model = ExpenseModel(
      id: entityValue.id,
      amount: entityValue.amount,
      date: entityValue.date,
      category: CategoryModel(
        id: entityValue.category.id,
        name: entityValue.category.name,
      ),
      note: entityValue.note,
    );

    return model;
  }
}
