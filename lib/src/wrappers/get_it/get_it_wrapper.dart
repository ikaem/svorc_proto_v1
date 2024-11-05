// @visibleForTesting

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:svorc_proto_v1/src/features/core/domain/values/app_repositories_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';

@visibleForTesting
final GetIt getIt = GetIt.instance;

abstract class GetItWrapper {
  static T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  }) {
    return getIt.get<T>(
      param1: param1,
      param2: param2,
      instanceName: instanceName,
      type: type,
    );
  }

  static void registerRepositories({
    required AppRepositoriesValue repositories,
  }) {
    getIt.registerSingleton<CategoriesRepository>(
        repositories.categoriesRepository);
    getIt
        .registerSingleton<ExpensesRepository>(repositories.expensesRepository);
    getIt.registerSingleton<PeriodDailyBudgetsRepository>(
        repositories.periodDailyBudgetsRepository);
  }
}
