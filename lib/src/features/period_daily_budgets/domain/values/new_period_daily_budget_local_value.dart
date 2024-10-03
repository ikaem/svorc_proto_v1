import 'package:equatable/equatable.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';

class NewPeriodDailyBudgetLocalValue extends Equatable {
  const NewPeriodDailyBudgetLocalValue({
    required this.periodStart,
    required this.periodEnd,
    required this.amount,
    required this.period,
  });

  final DateTime periodStart;
  final DateTime periodEnd;
  final int amount;
  final Period period;

  @override
  List<Object> get props => [
        periodStart,
        periodEnd,
        amount,
        period,
      ];
}
