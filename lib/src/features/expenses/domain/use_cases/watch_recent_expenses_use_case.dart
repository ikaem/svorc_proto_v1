import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/get_expenses_filter_value.dart';

class WatchRecentExpensesUseCase {
  const WatchRecentExpensesUseCase({
    required ExpensesRepository expensesRepository,
  }) : _expensesRepository = expensesRepository;

  final ExpensesRepository _expensesRepository;

  Stream<List<ExpenseModel>> call() {
    const GetExpensesFilterValue filter = GetExpensesFilterValue(
      limit: 5,
    );

    final Stream<List<ExpenseModel>> stream = _expensesRepository.watchExpenses(
      filter: filter,
    );

    return stream;
  }
}
