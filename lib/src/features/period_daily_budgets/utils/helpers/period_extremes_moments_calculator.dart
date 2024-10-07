// TODO this needs testing

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';

abstract class PeriodExtremesMomentsCalculator {
  static PeriodExtremesMoments calculateDayMoments({
    required int dayIndex,
    required int monthIndex,
    required int year,
  }) {
    final dayDate = DateTime(year, monthIndex, dayIndex);
    final nextDayDate = DateTime(year, monthIndex, dayIndex + 1);

    final firstMillisecondOfDay = dayDate.millisecondsSinceEpoch;
    final lastMillisecondOfDay = nextDayDate.millisecondsSinceEpoch - 1;

    final periodStart =
        DateTime.fromMillisecondsSinceEpoch(firstMillisecondOfDay);
    final periodEnd = DateTime.fromMillisecondsSinceEpoch(lastMillisecondOfDay);

    const period = Period.day;
    final periodName = DateFormat(DateFormat.DAY).format(dayDate);
    final periodIndex = dayIndex;

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

  static PeriodExtremesMoments calculateWeekMoments({
    required int dayIndex,
    required int monthIndex,
    required int year,
  }) {
    final dayDate = DateTime(year, monthIndex, dayIndex);
    final weekday = dayDate.weekday;

    final differenceToStartOfWeek = weekday - 1;

    final startOfWeekDate =
        DateTime(year, monthIndex, dayIndex - differenceToStartOfWeek);
    final startOfNextWeekDate = startOfWeekDate.add(const Duration(days: 7));
    final endOfWeekDate =
        startOfNextWeekDate.subtract(const Duration(milliseconds: 1));

    const Period period = Period.week;

    final weekIndex = Jiffy.parseFromDateTime(startOfWeekDate).weekOfYear;

    final PeriodExtremesMoments periodExtremesMoments = PeriodExtremesMoments(
      periodStart: startOfWeekDate,
      periodEnd: endOfWeekDate,
      period: period,
      // periodName: 'Week ${startOfWeekDate.weekOfYear}',
      periodName: 'Week $weekIndex',
      periodIndex: weekIndex,
      year: year,
    );

    return periodExtremesMoments;
  }

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
