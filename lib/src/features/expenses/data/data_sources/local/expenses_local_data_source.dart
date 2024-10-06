import 'package:equatable/equatable.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/expense_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';

abstract interface class ExpensesLocalDataSource {
// create expense
  Future<int> createExpense({
    required NewExpenseLocalValue newExpense,
  });

// update expense - allow to update amount, date, category, note
  Future<int> updateExpense({
    // TODO with time, we might need to wrap all this into a value class - some UpdateExpenseLocalValue
    // for now, we will just pass values as individual parameters
    required int id,
    int? amount,
    DateTime? date,
    int? categoryId,
    String? note,
  });

// get expenses - for now without filtering
// TODO v1.1 - add filtering value class to be used here
  Future<List<ExpenseLocalEntityValue>> getExpenses({
    required GetExpensesFilterValue filter,
  });

// get expense by id
  Future<ExpenseLocalEntityValue?> getExpenseById({
    required int id,
  });

// delete expense
  Future<int> deleteExpense({
    required int id,
  });
}

// TODO move to values folder
class GetExpensesFilterValue extends Equatable {
  const GetExpensesFilterValue({
    this.minDate,
    this.maxDate,
  });

  final DateTime? minDate;
  final DateTime? maxDate;

  @override
  List<Object?> get props => [minDate, maxDate];
}
