import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/core/domain/values/home_screen_expenses_state_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

part "home_cubit_state.dart";

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeCubitStateInitial());

  Future<void> onLoadData() async {
    final currentMonthDailyBudget =
        await _fakeGetCurrentMonthDailyBudgetuseCase();
    if (currentMonthDailyBudget == null) {
      emit(HomeCubitStateCurrentMonthDailyBudgetNotFound());
      return;
    }

    final currentMonthExpenses = await _fakeGetCurrentMonthExpensesUseCase();
  }
}

// TODO
Future<PeriodDailyBudgetModel?> _fakeGetCurrentMonthDailyBudgetuseCase() async {
  final model = PeriodDailyBudgetModel(
    id: 1,
    periodStart: DateTime.now(),
    periodEnd: DateTime.now(),
    amount: 1000,
    period: Period.month,
  );

  return model;
}

Future<List<ExpenseModel>> _fakeGetCurrentMonthExpensesUseCase() async {
  final random = Random();
  final todayDate = DateTime.now();
  final todayDay = todayDate.day;
  final randomDay = random.nextInt(todayDay + 1);

  // todayDate.weekday;

  final expenses = List.generate(
    100,
    (index) {
      final randomDateUpToToday = todayDate.subtract(Duration(
        days: randomDay,
      ));

      // final randomDateUpToToday = DateTime(todayDate.year, todayDate.month, randomDay);

      return ExpenseModel(
        id: index,
        amount: random.nextInt(10000),
        // date: DateTime.now()
        date: randomDateUpToToday,
        category: CategoryModel(
          id: index,
          name: "Category $index",
        ),
        // description: "Expense $index",
      );
    },
  );

  return expenses;
}

HomeScreenPeriodAmounts _getTodayPeriodAmounts({
  required List<ExpenseModel> expenses,
  required PeriodDailyBudgetModel dailyBudget,
}) {
  final today = DateTime.now();

  final todayExtremesMoments =
      PeriodExtremesMomentsCalculator.calculateDayMoments(
    dayIndex: today.day,
    monthIndex: today.month,
    year: today.year,
  );

  final todayExpenses = expenses.where((expense) {
    final isWithinTodayStart = expense.date.millisecondsSinceEpoch >=
        todayExtremesMoments.periodStart.millisecondsSinceEpoch;
    final isWithinTodayEnd = expense.date.millisecondsSinceEpoch <=
        todayExtremesMoments.periodEnd.millisecondsSinceEpoch;

    return isWithinTodayStart && isWithinTodayEnd;
  }).toList();

  final spent = todayExpenses.fold<int>(
    0,
    (previousValue, element) => previousValue + element.amount,
  );

  final remainder = dailyBudget.amount - spent;

// TODO this will not work - this needs data from yesterday too
  final accumulation = dailyBudget.amount - remainder;

  throw UnimplementedError();
}

/* 

// lets get stuff created

// we first need all expenses for this month
// and then we want to create list with items for each day of month

// then we want to create some objects for each day, existing or not, with values 
- period
- spent
- remainder
- accumulation
- name
- date

- so we only get days here

- and then after we get days, we can do calculations

- for day, we get remainder and accumulation, and spent easily
- for week, we calculate remainder and spent, and we get accumulation on the last day of the week
- for month, we calculation remainder and spent for entire period, and we get accumulation on the last day of the month



 */

// TODO extend Equatable

class HomeScreenBalanceStateValue extends Equatable {
  const HomeScreenBalanceStateValue({
    required List<DayBalance> monthDayBalances,
  }) : _monthDayBalances = monthDayBalances;

  final List<DayBalance> _monthDayBalances;

  // DayBalance getTodayBalance() {
  //   final today = DateTime.now();
  //   final todayBalance = _monthDayBalances.firstWhere(
  //     (element) {
  //       final todayStart = DateTime(
  //         today.year,
  //         today.month,
  //         today.day,
  //       );

  //       final dayBalanceStart = DateTime(
  //         element.date.year,
  //         element.date.month,
  //         element.date.day,
  //       );

  //       final isEqual = todayStart == dayBalanceStart;

  //       return isEqual;
  //     },
  //   );

  //   return todayBalance;
  // }

  // void getThisWeekBalance(int dailyBudgetAmount) {
  //   // find this week start
  //   final today = DateTime.now();

  //   final weekMoments = PeriodExtremesMomentsCalculator.calculateWeekMoments(
  //     dayIndex: today.day,
  //     monthIndex: today.month,
  //     year: today.year,
  //   );

  //   // now get all balances in this week
  //   final thisWeekBalances = _monthDayBalances.where(
  //     (element) {
  //       final isWithinWeekStart = element.date.millisecondsSinceEpoch >=
  //           weekMoments.periodStart.millisecondsSinceEpoch;
  //       final isWithinWeekEnd = element.date.millisecondsSinceEpoch <=
  //           weekMoments.periodEnd.millisecondsSinceEpoch;

  //       return isWithinWeekStart && isWithinWeekEnd;
  //     },
  //   ).toList();

  //   // now we have all balances in this week

  //   // lets calculate total spent
  //   final totalSpent = thisWeekBalances.fold<int>(
  //     0,
  //     (previousValue, element) => previousValue + element.spentAmount,
  //   );

  //   // lets calculate total remainder this week
  //   final totalRemainder = thisWeekBalances.fold<int>(
  //     0,
  //     (previousValue, element) =>
  //         previousValue + element.getRemainderAmount(dailyBudgetAmount),
  //   );

  //   final accumulation = thisWeekBalances.last.getAccumulationAmount(
  //     dailyBudgetAmount,
  //     0,
  //   );
  // }

  @override
  List<Object?> get props => [];
}

class DayBalance extends Equatable {
  const DayBalance({
    required this.date,
    required this.period,
    required this.spentAmount,
  });

  final DateTime date;
  final Period period;
  final int spentAmount;

  int getRemainderAmount(int dailyBudgetAmount) {
    return dailyBudgetAmount - spentAmount;
  }

  int getAccumulationAmount(
    int dailyBudgetAmount,
    int prevDayAccumulationAmount,
  ) {
    final todayRemainderAmount = getRemainderAmount(dailyBudgetAmount);
    final todayAccumulationAmount =
        todayRemainderAmount + prevDayAccumulationAmount;

    return todayAccumulationAmount;
  }

  @override
  List<Object?> get props => [date, period, spentAmount];
}

/* 

// lets do again

// lets create class that actually holds all these values 

// lets create a function that accepts a list of day balanceGenerators, and returns a list of day balances

- this class has 
- date 
- spent
- remainder calculator
- accumulation calculator


first, function to add up all expenses within a day


ok, now function that will accept a list of expense models and create a list of day balance generators










 */

// day expense model

// TODO lets make a whole helper out of this - and test it

List<DayBalanceValue> getDaysBalances({
  required List<DateExpenseSum> monthDatesExpensesSum,
  required int dailyBudgetAmount,
}) {
  final List<DayBalanceValue> dayBalances = [];

  final sortedMonthDatesExpensesSum = [...monthDatesExpensesSum];
  sortedMonthDatesExpensesSum.sort(
    (a, b) => a.date.compareTo(b.date),
  );

// THIS NEEDS to be sorted, because it expects that first day is first day of month
  for (int i = 0; i < sortedMonthDatesExpensesSum.length; i++) {
    final dateExpenseSum = monthDatesExpensesSum[i];

    final DayBalanceGenerator dayBalanceGenerator = DayBalanceGenerator(
      date: dateExpenseSum.date,
      spentValue: dateExpenseSum.amount,
    );

    final remainderValue = dayBalanceGenerator.getRemainderValue(
      dailyBudgetAmount,
    );

    final prevAccumulationValue =
        i == 0 ? 0 : dayBalances[i - 1].accumulationValue;

    final accumulationValue = dayBalanceGenerator.getAccumulationValue(
      dailyBudgetAmount,
      prevAccumulationValue,
    );

    final dayBalanceValue = DayBalanceValue(
      date: dateExpenseSum.date,
      spentValue: dateExpenseSum.amount,
      remainderValue: remainderValue,
      accumulationValue: accumulationValue,
    );

    dayBalances.add(dayBalanceValue);
  }

  return dayBalances;
}

List<DateExpenseSum> getMonthDatesExpensesSum({
  required List<ExpenseModel> expenses,
  required PeriodExtremesMoments monthMoments,
}) {
  // here we want to generate list with all month dates

  final monthDate = monthMoments.periodStart;
  // get number of days in month
  final daysInMonth = DateUtils.getDaysInMonth(monthDate.year, monthDate.month);

// in case there is no expenses for specific day, we want to create empty object
  final List<DateExpenseSum> monthDatesExpensesSum = List.generate(
    daysInMonth,
    (index) {
      final date = DateTime(
        monthDate.year,
        monthDate.month,
        index + 1,
      );

      final dateExpenseSum = getDateExpenseSum(
        expenses: expenses,
        date: date,
      );

      return dateExpenseSum;
    },
  );

  return monthDatesExpensesSum;
}

DateExpenseSum getDateExpenseSum({
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

  return DateExpenseSum(
    date: normalizedDate,
    amount: sum,
  );
}

class DateExpenseSum {
  DateExpenseSum({
    required this.date,
    required this.amount,
  });

  final DateTime date;
  final int amount;
}

class DayBalanceGenerator {
  DayBalanceGenerator({
    required this.date,
    required this.spentValue,
  });

  final DateTime date;
  final int spentValue;

  int getRemainderValue(int dailyBudgetAmount) {
    return dailyBudgetAmount - spentValue;
  }

  int getAccumulationValue(
    int dailyBudgetAmount,
    int prevDayAccumulationValue,
  ) {
    final todayRemainderValue = getRemainderValue(dailyBudgetAmount);
    final todayAccumulationValue =
        todayRemainderValue + prevDayAccumulationValue;

    return todayAccumulationValue;
  }
}

class DayBalanceValue extends Equatable {
  const DayBalanceValue({
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
