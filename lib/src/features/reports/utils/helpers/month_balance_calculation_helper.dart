import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/date_balance_calculation_helper.dart';

class MonthBalanceCalculationHelper {
  MonthBalanceCalculationHelper({
    required List<ExpenseModel> monthExpenses,
    required int dailyBudget,
    // required PeriodExtremesMoments monthMoments,
    required DateTime monthDate,
  })  : _monthExpenses = monthExpenses,
        _dailyBudget = dailyBudget,
        _monthDate = monthDate;

  final List<ExpenseModel> _monthExpenses;
  final int _dailyBudget;
  final DateTime _monthDate;
  // final PeriodExtremesMoments _monthMoments;
  // final PeriodExtremesMoments _periodExtremesMoments;
  // this needs first
  // - generate day balance value

  // lets get first all all days in the month

  // now we can get
  // - balance for today
  // - balance for this week
  // - balance for this month

  WeekBalanceValue get weekBalance {
    // get today
    final todayDate = DateTime.now();

    // get extreme moments for the current week
    final weekMoments = PeriodExtremesMomentsCalculator.calculateWeekMoments(
      dayIndex: todayDate.day,
      monthIndex: todayDate.month,
      year: todayDate.year,
    );

    // filter all day balance values of the week
    final weekDatesBalances = datesBalances.where(
      (element) {
        final isWithinStart = element.date.millisecondsSinceEpoch >=
            weekMoments.periodStart.millisecondsSinceEpoch;
        final isWithinEnd = element.date.millisecondsSinceEpoch <=
            weekMoments.periodEnd.millisecondsSinceEpoch;

        return isWithinStart && isWithinEnd;
      },
    ).toList();

    // calculate week balance value
    final spentValue = weekDatesBalances.fold<int>(
      0,
      (previousValue, element) => previousValue + element.spentValue,
    );

    final remainderValue = weekDatesBalances.fold<int>(
      0,
      (previousValue, element) => previousValue + element.remainderValue,
    );

    final accumulationValue = weekDatesBalances.last.accumulationValue;

    final balance = WeekBalanceValue(
      date: weekMoments.periodStart,
      spentValue: spentValue,
      remainderValue: remainderValue,
      accumulationValue: accumulationValue,
    );

    return balance;
  }

  MonthBalanceValue get monthBalance {
    final normalizedMonthDate = DateTime(
      _monthDate.year,
      _monthDate.month,
      1,
    );
    final spentValue = datesBalances.fold<int>(
      0,
      (previousValue, element) => previousValue + element.spentValue,
    );

    final remainderValue = datesBalances.fold<int>(
      0,
      (previousValue, element) => previousValue + element.remainderValue,
    );

    final accumulationValue = datesBalances.last.accumulationValue;

    final balance = MonthBalanceValue(
      date: normalizedMonthDate,
      spentValue: spentValue,
      remainderValue: remainderValue,
      accumulationValue: accumulationValue,
    );

    return balance;
  }

  DateBalanceValue get todayBalance {
    final todayDate = DateTime.now();
    final normalizedTodayDate = DateTime(
      todayDate.year,
      todayDate.month,
      todayDate.day,
    );
    // TODO this can throw - be careful here
    final balance = datesBalances.firstWhere(
      (element) {
        final normalizedElementDate = DateTime(
          element.date.year,
          element.date.month,
          element.date.day,
        );

        return normalizedElementDate == normalizedTodayDate;
      },
    );

    return balance;
  }

  List<DateBalanceValue> get datesBalances {
    final List<DateBalanceValue> datesBalances = [];

    final sortedDatesExpensesSums = _sortedDatesExpensesSums;

    for (int i = 0; i < sortedDatesExpensesSums.length; i++) {
      final dateExpenseSum = sortedDatesExpensesSums[i];

      final DateBalanceGeneratorHelper dateBalanceGenerator =
          DateBalanceGeneratorHelper(
        date: dateExpenseSum.date,
        spentValue: dateExpenseSum.sum,
      );

      final remainderValue = dateBalanceGenerator.getRemainderValue(
        _dailyBudget,
      );

      // if we are on the first day, there is no accumulation value
      final previousDayAccumulationValue =
          i == 0 ? 0 : datesBalances[i - 1].accumulationValue;
      final accumulationValue = dateBalanceGenerator.getAccumulationValue(
        _dailyBudget,
        previousDayAccumulationValue,
      );

      final dateBalanceValue = DateBalanceValue(
        date: dateExpenseSum.date,
        spentValue: dateExpenseSum.sum,
        remainderValue: remainderValue,
        accumulationValue: accumulationValue,
      );

      datesBalances.add(dateBalanceValue);
    }

    return datesBalances;
  }

  List<DateExpenseSumValue> get _sortedDatesExpensesSums {
    // final monthDate = _monthMoments.periodStart;
    final monthDate = _monthDate;
    final daysInMonth = DateUtils.getDaysInMonth(
      monthDate.year,
      monthDate.month,
    );

    // this will also sort it
// in case there is no expenses for specific day, we want to create empty object
    final List<DateExpenseSumValue> monthDatesExpensesSum = List.generate(
      daysInMonth,
      (index) {
        final date = DateTime(
          monthDate.year,
          monthDate.month,
          index + 1,
        );

        final dateExpenseSum = _getDateExpenseSum(
          expenses: _monthExpenses,
          date: date,
        );

        return dateExpenseSum;
      },
    );

    return monthDatesExpensesSum;
  }

  DateExpenseSumValue _getDateExpenseSum({
    required List<ExpenseModel> expenses,
    required DateTime date,
  }) {
    final normalizedDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final dateExpenses = expenses.where(
      (expense) {
        final normalizedExpenseDate = DateTime(
          expense.date.year,
          expense.date.month,
          expense.date.day,
        );

        return normalizedExpenseDate == normalizedDate;
      },
    ).toList();

    final sum = dateExpenses.fold<int>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );

    return DateExpenseSumValue(
      date: normalizedDate,
      sum: sum,
    );
  }
}

// TODO move to separate file
class DateBalanceValue extends Equatable {
  const DateBalanceValue({
    required this.date,
    required this.spentValue,
    required this.remainderValue,
    required this.accumulationValue,
  });

  final DateTime date;
  final int spentValue;
  final int remainderValue;
  final int accumulationValue;

  @override
  List<Object?> get props =>
      [date, spentValue, remainderValue, accumulationValue];
}

// TODO try this only
class WeekBalanceValue extends Equatable {
  const WeekBalanceValue({
    required this.date,
    required this.spentValue,
    required this.remainderValue,
    required this.accumulationValue,
  });

  final DateTime date;
  final int spentValue;
  final int remainderValue;
  final int accumulationValue;

  @override
  List<Object?> get props =>
      [date, spentValue, remainderValue, accumulationValue];
}

class MonthBalanceValue extends Equatable {
  const MonthBalanceValue({
    required this.date,
    required this.spentValue,
    required this.remainderValue,
    required this.accumulationValue,
  });

  final DateTime date;
  final int spentValue;
  final int remainderValue;
  final int accumulationValue;

  @override
  List<Object?> get props =>
      [date, spentValue, remainderValue, accumulationValue];
}

class DateExpenseSumValue extends Equatable {
  const DateExpenseSumValue({
    required this.date,
    required this.sum,
  });

  final DateTime date;
  final int sum;

  @override
  List<Object?> get props => [date, sum];
}
