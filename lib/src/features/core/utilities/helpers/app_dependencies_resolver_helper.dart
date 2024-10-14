// TODO how to test this

import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source_impl.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository_impl.dart';
import 'package:svorc_proto_v1/src/features/core/domain/values/app_repositories_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source_impl.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository_impl.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/data_sources/local/period_daily_budgets_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/data_sources/local/period_daily_budgets_local_data_source_impl.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository_impl.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_database_wrapper.dart';

class AppDependenciesResolverHelper {
  const AppDependenciesResolverHelper(this.driftDatabaseWrapper);

  final DriftDatabaseWrapper driftDatabaseWrapper;

  AppRepositoriesValue resolveRepositories() {
    // TODO extract to separate function when too many data sources appear
    // data sources
    final PeriodDailyBudgetsLocalDataSource periodDailyBudgetsLocalDataSource =
        PeriodDailyBudgetsLocalDataSourceImpl(
            databaseWrapper: driftDatabaseWrapper);
    final ExpensesLocalDataSource expensesLocalDataSource =
        ExpensesLocalDataSourceImpl(databaseWrapper: driftDatabaseWrapper);

    final CategoriesLocalDataSource categoriesLocalDataSource =
        CategoriesLocalDataSourceImpl(databaseWrapper: driftDatabaseWrapper);

    // repositories
    final PeriodDailyBudgetsRepository periodDailyBudgetsRepository =
        PeriodDailyBudgetsRepositoryImpl(
      periodDailyBudgetLocalDataSource: periodDailyBudgetsLocalDataSource,
    );
    final ExpensesRepository expensesRepository = ExpensesRepositoryImpl(
      expensesLocalDataSource: expensesLocalDataSource,
    );
    final CategoriesRepository categoriesRepository = CategoriesRepositoryImpl(
      categoriesLocalDataSource: categoriesLocalDataSource,
    );

    // values
    final AppRepositoriesValue appRepositoriesValue = AppRepositoriesValue(
      periodDailyBudgetsRepository: periodDailyBudgetsRepository,
      expensesRepository: expensesRepository,
      categoriesRepository: categoriesRepository,
    );

    return appRepositoriesValue;
  }
}
