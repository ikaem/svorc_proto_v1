// TODO this needs testing

import 'package:intl/intl.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';

abstract class PeriodExtremesMomentsCalculator {
  static PeriodExtremesMoments calculateMonthMoments({
    required int monthIndex,
    required int year,
  }) {
    final monthDate = DateTime(year, monthIndex, 1);
    final nextMonthDate = DateTime(year, monthIndex + 1, 1);

    final firstMillisecondOfMonth = monthDate.millisecondsSinceEpoch;
    final lastMillisecondOfMonth = nextMonthDate.millisecondsSinceEpoch - 1;

    final periodStart =
        DateTime.fromMillisecondsSinceEpoch(firstMillisecondOfMonth);
    final periodEnd =
        DateTime.fromMillisecondsSinceEpoch(lastMillisecondOfMonth);
    const period = Period.month;
    final periodName = DateFormat(DateFormat.MONTH).format(monthDate);
    final periodIndex = monthIndex;

    final periodExtremesMoments = PeriodExtremesMoments(
      periodStart: periodStart,
      periodEnd: periodEnd,
      period: period,
      periodName: periodName,
      periodIndex: periodIndex,
      year: year,
    );

    return periodExtremesMoments;
  }
}

class PeriodExtremesMoments {
  const PeriodExtremesMoments({
    required this.periodStart,
    required this.periodEnd,
    required this.period,
    required this.periodName,
    required this.periodIndex,
    required this.year,
  });

  final DateTime periodStart;
  final DateTime periodEnd;
  final Period period;
  final String periodName;
  final int periodIndex;
  final int year;
}
