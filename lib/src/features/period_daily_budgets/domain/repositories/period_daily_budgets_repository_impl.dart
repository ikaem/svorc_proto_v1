import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/data_sources/local/period_daily_budgets_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/values/new_period_daily_budget_local_value.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/converters/period_daily_budget_converters.dart';

class PeriodDailyBudgetsRepositoryImpl implements PeriodDailyBudgetsRepository {
  PeriodDailyBudgetsRepositoryImpl({
    required PeriodDailyBudgetsLocalDataSource periodDailyBudgetLocalDataSource,
  }) : _periodDailyBudgetLocalDataSource = periodDailyBudgetLocalDataSource;

  final PeriodDailyBudgetsLocalDataSource _periodDailyBudgetLocalDataSource;

  @override
  Future<int> createPeriodDailyBudget({
    required NewPeriodDailyBudgetLocalValue newPeriodDailyBudget,
  }) async {
    // TODO: implement createPeriodDailyBudget
    // throw UnimplementedError();
    final id = await _periodDailyBudgetLocalDataSource.createPeriodDailyBudget(
      newPeriodDailyBudget: newPeriodDailyBudget,
    );

    return id;
  }

  @override
  Future<PeriodDailyBudgetModel?> getPeriodDailyBudgetByDateAndPeriod({
    required DateTime date,
    required Period period,
  }) async {
    final entityValue = await _periodDailyBudgetLocalDataSource
        .getPeriodDailyBudgetByDateAndPeriod(date: date, period: period);
    if (entityValue == null) {
      return null;
    }
    final model = PeriodDailyBudgetConverters.toModelFromEntityValue(
        entityValue: entityValue);
    return model;
  }

  @override
  Future<PeriodDailyBudgetModel?> getPeriodDailyBudgetById(
      {required int id}) async {
    final entityValue = await _periodDailyBudgetLocalDataSource
        .getPeriodDailyBudgetById(id: id);
    if (entityValue == null) {
      return null;
    }
    final model = PeriodDailyBudgetConverters.toModelFromEntityValue(
        entityValue: entityValue);
    return model;
  }

  @override
  Future<int> updatePeriodDailyBudget({
    required int amount,
    required int id,
  }) async {
    final updatedId =
        await _periodDailyBudgetLocalDataSource.updatePeriodDailyBudget(
      amount: amount,
      id: id,
    );
    return updatedId;
  }
}
