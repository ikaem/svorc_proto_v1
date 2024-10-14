import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';

class AppRepositoriesValue {
  const AppRepositoriesValue({
    required this.periodDailyBudgetsRepository,
    required this.expensesRepository,
    required this.categoriesRepository,
  });

  final PeriodDailyBudgetsRepository periodDailyBudgetsRepository;
  final ExpensesRepository expensesRepository;
  final CategoriesRepository categoriesRepository;
}
