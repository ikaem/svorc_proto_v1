import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';

class GetRecentExpensesUseCase {
  const GetRecentExpensesUseCase({
    required ExpensesRepository expensesRepository,
  }) : _expensesRepository = expensesRepository;

  final ExpensesRepository _expensesRepository;

  Future<List<ExpenseModel>> call() async {
    const GetExpensesFilterValue filter = GetExpensesFilterValue(
      limit: 5,
    );
    final List<ExpenseModel> recentExpenses =
        await _expensesRepository.getExpenses(filter: filter);

    return recentExpenses;
  }
}
