import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';

class CreateExpenseUseCase {
  const CreateExpenseUseCase({
    required ExpensesRepository expensesRepository,
  }) : _expensesRepository = expensesRepository;

  final ExpensesRepository _expensesRepository;

  Future<int> call({
    required int amount,
    required DateTime date,
    required String? note,
    required int categoryId,
  }) async {
    final NewExpenseLocalValue value = NewExpenseLocalValue(
      amount: amount,
      date: date,
      note: note,
      categoryId: categoryId,
    );

    final id = await _expensesRepository.createExpense(newExpense: value);

    return id;
  }
}
