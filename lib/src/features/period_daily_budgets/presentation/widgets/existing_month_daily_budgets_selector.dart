import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/presentation/widgets/edit_month_daily_budget_new.dart';

class ExistingMonthDailyBudgetsSelector extends StatefulWidget {
  const ExistingMonthDailyBudgetsSelector({
    super.key,
    // required this.budgets,
    required this.existingMonthDailyBudgetsValue,
    required this.onCancelSelect,
    required this.onSelect,
  });

  final ExistingMonthDailyBudgetsValue existingMonthDailyBudgetsValue;
  final VoidCallback onCancelSelect;
  // TODO this will initially need to send selected bugdet to the edit widget
  final Function(PeriodDailyBudgetModel) onSelect;

  @override
  State<ExistingMonthDailyBudgetsSelector> createState() =>
      _ExistingMonthDailyBudgetsSelectorState();
}

class _ExistingMonthDailyBudgetsSelectorState
    extends State<ExistingMonthDailyBudgetsSelector> {
  late PeriodDailyBudgetModel selectedBudget =
      widget.existingMonthDailyBudgetsValue.thisMonthBudget;
  late int selectedYear =
      widget.existingMonthDailyBudgetsValue.thisMonthBudget.periodStart.year;

  // final List<PeriodDailyBudgetModel> budgets;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: Text("Hello existing month daily budgets selector"),
        ),
        Text("Selected year: $selectedYear"),
        Text("Selected budget: ${selectedBudget.periodStart.month}"),
        TextButton(
          onPressed: () {
            final years = widget.existingMonthDailyBudgetsValue.years;

            // now get length of this
            final yearsLength = years.length;

            if (yearsLength == 0) return;
            if (yearsLength == 1) return;

            // now we know there are more than 1 item
            // check if index of current year is bigger than lenght
            final currentYearIndex = years.indexOf(selectedYear);
            if (currentYearIndex >= years.length - 1) return;

            // now we know current year is not the last one
            final nextYearIndex = currentYearIndex + 1;
            final nextYear = years[nextYearIndex];

            setState(() {
              selectedYear = nextYear;
            });
          },
          child: const Text("Next year"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Open daily budgets selector temp"),
        ),
      ],
    );
  }
}

// how should we make selector of years
// selector should only show ear selections for those year that exist in the map i guess

// and then each year should have a list of months

// can we make a model for it

// model should be called existing budgets year yelections
