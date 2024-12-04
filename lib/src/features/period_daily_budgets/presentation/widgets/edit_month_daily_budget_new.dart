// TODO remove this new eventually
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/dialog_wrapper.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/presentation/widgets/existing_month_daily_budgets_selector.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

class EditMonthDailyBudgetNew extends StatelessWidget {
  const EditMonthDailyBudgetNew({
    super.key,
    required this.onCancelEdit,
    required this.onSaveEdit,
  });

  final VoidCallback onCancelEdit;
  final VoidCallback onSaveEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: Text("Hello new edit budget widget"),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                // TODO temp only
                final existingBudgets =
                    _getTempExistingMonthDailyBudgetsValue();

                return DialogWrapper(
                  child: ExistingMonthDailyBudgetsSelector(
                    existingMonthDailyBudgetsValue: existingBudgets,
                    onCancelSelect: () {
                      Navigator.of(context).pop();
                    },
                    onSelect: (PeriodDailyBudgetModel selectedBudget) {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          child: const Text("Open daily budgets selector temp"),
        ),
        // TODO temp
        Row(
          children: [
            TextButton(
              onPressed: onCancelEdit,
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: onSaveEdit,
              child: const Text("Save"),
            ),
          ],
        )
      ],
    );
  }
}

// TODO move this to values

// TODO maybe this should be returned by the controller
class ExistingMonthDailyBudgetsValue extends Equatable {
  const ExistingMonthDailyBudgetsValue({
    required List<PeriodDailyBudgetModel> budgets,
  }) : _budgets = budgets;

  final List<PeriodDailyBudgetModel> _budgets;

  List<int> get years =>
      _budgets.map((e) => e.periodStart.year).toSet().toList()..sort();

  List<PeriodDailyBudgetModel> getBudgetsForYear(int year) {
    return _budgets
        .where((element) => element.periodStart.year == year)
        .toList();
    // TODO this will need to be sorted
    // ..sort();
  }

  PeriodDailyBudgetModel get thisMonthBudget {
    final now = DateTime.now();
    final PeriodExtremesMoments extremes =
        PeriodExtremesMomentsCalculator.calculateMonthMoments(
            monthIndex: now.month, year: now.year);

    final budget =
        _budgets.firstWhere((b) => b.periodStart == extremes.periodStart);

    return budget;
  }

  @override
  List<Object?> get props => [_budgets];
}

ExistingMonthDailyBudgetsValue _getTempExistingMonthDailyBudgetsValue() {
  final monthNumbers = List.generate(12, (index) => index + 1);

  final monthDatesThisYear = monthNumbers
      .map((monthNumber) => DateTime(DateTime.now().year, monthNumber))
      .toList();

  final monthDatesPrevYear = monthNumbers
      .getRange(5, 12)
      .map((monthNumber) => DateTime(DateTime.now().year - 1, monthNumber))
      .toList();

  final monthDates = [
    ...monthDatesThisYear,
    ...monthDatesPrevYear,
  ];

  final budgets = monthDates.map((date) {
    final extremes = PeriodExtremesMomentsCalculator.calculateMonthMoments(
        monthIndex: date.month, year: date.year);
    return PeriodDailyBudgetModel(
      amount: 100,
      id: date.month,
      period: extremes.period,
      periodStart: extremes.periodStart,
      periodEnd: extremes.periodEnd,

      // periodEnd: date.add(duration)
    );
  }).toList();

  final existingMonthDailyBudgetsValue =
      ExistingMonthDailyBudgetsValue(budgets: budgets);

  return existingMonthDailyBudgetsValue;
}
