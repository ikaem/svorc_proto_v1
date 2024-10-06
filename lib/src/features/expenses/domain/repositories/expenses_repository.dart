import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';

abstract interface class ExpensesRepository {
  Future<int> createExpense({
    required NewExpenseLocalValue newExpense,
  });

  Future<int> updateExpense({
    required int id,
    int? amount,
    DateTime? date,
    int? categoryId,
    String? note,
  });

  Future<List<ExpenseModel>> getExpenses();

  Future<ExpenseModel?> getExpenseById({
    required int id,
  });

  Future<int> deleteExpense({
    required int id,
  });
}
