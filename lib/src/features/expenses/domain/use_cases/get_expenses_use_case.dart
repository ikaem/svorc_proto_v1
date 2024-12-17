import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/get_expenses_filter_value.dart';

class GetExpensesUseCase {
  const GetExpensesUseCase({
    required ExpensesRepository expensesRepository,
  }) : _expensesRepository = expensesRepository;

  final ExpensesRepository _expensesRepository;

  Future<List<ExpenseModel>> call(GetExpensesFilterValue filter) async {
    final List<ExpenseModel> expenses =
        await _expensesRepository.getExpenses(filter: filter);

    return expenses;
  }
}
