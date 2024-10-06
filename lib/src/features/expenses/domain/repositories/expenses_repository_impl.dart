import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/utils/converters/expenses_converters.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  const ExpensesRepositoryImpl({
    required this.expensesLocalDataSource,
  });

  final ExpensesLocalDataSource expensesLocalDataSource;

  @override
  Future<int> createExpense({
    required NewExpenseLocalValue newExpense,
  }) async {
    final id = await expensesLocalDataSource.createExpense(
      newExpense: newExpense,
    );

    return id;
  }

  @override
  Future<int> updateExpense({
    required int id,
    int? amount,
    DateTime? date,
    int? categoryId,
    String? note,
  }) async {
    final updatedId = await expensesLocalDataSource.updateExpense(
      id: id,
      amount: amount,
      date: date,
      categoryId: categoryId,
      note: note,
    );

    return updatedId;
  }

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final expenseEntityValues = await expensesLocalDataSource.getExpenses();
    final expenseModels = expenseEntityValues
        .map((e) => ExpensesConverters.toModelFromEntityValue(entityValue: e))
        .toList();

    return expenseModels;
  }

  @override
  Future<ExpenseModel?> getExpenseById({
    required int id,
  }) async {
    final entityValue = await expensesLocalDataSource.getExpenseById(id: id);
    if (entityValue == null) {
      return null;
    }

    final model =
        ExpensesConverters.toModelFromEntityValue(entityValue: entityValue);
    return model;
  }

  @override
  Future<int> deleteExpense({
    required int id,
  }) async {
    final deletedId = await expensesLocalDataSource.deleteExpense(id: id);

    return deletedId;
  }
}
