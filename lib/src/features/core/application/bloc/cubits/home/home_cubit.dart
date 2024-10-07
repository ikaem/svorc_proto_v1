import 'dart:math';

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
}
