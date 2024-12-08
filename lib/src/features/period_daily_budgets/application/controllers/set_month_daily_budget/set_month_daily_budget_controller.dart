import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

part "set_month_daily_budget_controller_state_data.dart";
part "set_month_daily_budget_controller.g.dart";
part "set_month_daily_budget_controller_value.dart";

// TODO this should probably be called SelectMonthDailyBudgetController
@riverpod
class SetMonthDailyBudgetController extends _$SetMonthDailyBudgetController {
  // TODO not sure - maybe it can

  late final _SetMonthDailyBudgetControllerValue
      _monthDailyBudgetsSelectorControllerValue;

// TODO no need to be async value - we will always have actual data
  @override
  SetMonthDailyBudgetControllerStateData build(
    List<PeriodDailyBudgetModel> budgets,
  ) {
    if (budgets.isEmpty) {
      // throw Exception("No budgets provided");
      return SetMonthDailyBudgetControllerStateDataNoBudgetsProvided();
    }

    // final Existing
    // TODO all this should be renamed to match class name
    // TODO this could throw potentially if current month does not exist in provided budgets
    // TODO handle this in future
    _monthDailyBudgetsSelectorControllerValue =
        _SetMonthDailyBudgetControllerValue(
      budgets: budgets,
    );

    final SetMonthDailyBudgetControllerStateDataSelections stateData =
        SetMonthDailyBudgetControllerStateDataSelections(
      selectedBudget: _monthDailyBudgetsSelectorControllerValue.thisMonthBudget,
      selectedYear: _monthDailyBudgetsSelectorControllerValue
          .thisMonthBudget.periodStart.year,
      years: _monthDailyBudgetsSelectorControllerValue.years,
      selectedYearBudgets: _monthDailyBudgetsSelectorControllerValue
          .getBudgetsForYear(_monthDailyBudgetsSelectorControllerValue
              .thisMonthBudget.periodStart.year),
    );

    return stateData;
    // return What();
  }

  // on set budget
  void onSetBudget(PeriodDailyBudgetModel budget) {
    final newSelectedBudget = budget;
    final newSelectedYear = budget.periodStart.year;
    final newYears = _monthDailyBudgetsSelectorControllerValue.years;
    final newSelectedYearBudgets = _monthDailyBudgetsSelectorControllerValue
        .getBudgetsForYear(newSelectedYear);

    state = SetMonthDailyBudgetControllerStateDataSelections(
      selectedBudget: newSelectedBudget,
      selectedYear: newSelectedYear,
      years: newYears,
      selectedYearBudgets: newSelectedYearBudgets,
    );
  }

  // on set year
  void onSetYear(int year) {
    // ignore: unnecessary_cast
    // final oldState = state as SetMonthDailyBudgetControllerStateData;
    final SetMonthDailyBudgetControllerStateData oldState = state;

    // if (oldState is SetMonthDailyBudgetControllerStateDataNoBudgetsProvided) {
    //   return;
    // }

    switch (oldState) {
      case SetMonthDailyBudgetControllerStateDataNoBudgetsProvided():
        return;
      case SetMonthDailyBudgetControllerStateDataSelections():
        // TODO: Handle this case.
        final newSelectedBudget = oldState.selectedBudget;
        final newSelectedYear = year;
        final newYears = _monthDailyBudgetsSelectorControllerValue.years;
        final newSelectedYearBudgets =
            _monthDailyBudgetsSelectorControllerValue.getBudgetsForYear(year);

        state = SetMonthDailyBudgetControllerStateDataSelections(
          selectedBudget: newSelectedBudget,
          selectedYear: newSelectedYear,
          years: newYears,
          selectedYearBudgets: newSelectedYearBudgets,
        );
    }

    // return switch (state) {
    //   // TODO: Handle this case.
    //   SetMonthDailyBudgetControllerStateDataNoBudgetsProvided => state,
    //   // TODO: Handle this case.
    //   SetMonthDailyBudgetControllerStateDataSelections() =>
    //     throw UnimplementedError(),
    // };

    // final newSelectedBudget = oldState.selectedBudget;
    // final newSelectedYear = year;
    // final newYears = _monthDailyBudgetsSelectorControllerValue.years;
    // final newSelectedYearBudgets =
    //     _monthDailyBudgetsSelectorControllerValue.getBudgetsForYear(year);

    // state = SetMonthDailyBudgetControllerStateDataSelections(
    //   selectedBudget: newSelectedBudget,
    //   selectedYear: newSelectedYear,
    //   years: newYears,
    //   selectedYearBudgets: newSelectedYearBudgets,
    // );
  }

  // on next year
  void onSetNextYear() {
    final SetMonthDailyBudgetControllerStateData oldState = state;

    switch (oldState) {
      case SetMonthDailyBudgetControllerStateDataNoBudgetsProvided():
        return;
      case SetMonthDailyBudgetControllerStateDataSelections():
        final years = _monthDailyBudgetsSelectorControllerValue.years;

        final selectedYear = oldState.selectedYear;

        final selectedYearIndex = years.indexOf(selectedYear);

        // if it is last element, return
        if (selectedYearIndex >= years.length) return;

        // now it is not last element
        final nextYearIndex = selectedYearIndex + 1;
        final nextYear = years[nextYearIndex];

        final newSelectedBudget = oldState.selectedBudget;
        final newSelectedYear = nextYear;
        final newYears = _monthDailyBudgetsSelectorControllerValue.years;
        final newSelectedYearBudgets = _monthDailyBudgetsSelectorControllerValue
            .getBudgetsForYear(nextYear);

        state = SetMonthDailyBudgetControllerStateDataSelections(
          selectedBudget: newSelectedBudget,
          selectedYear: newSelectedYear,
          years: newYears,
          selectedYearBudgets: newSelectedYearBudgets,
        );
    }

    // final years = _monthDailyBudgetsSelectorControllerValue.years;

    // final selectedYear = state.selectedYear;

    // // check if index of current year is bigger than lenght of years
    // // or we can just check if it is the last element
    // final selectedYearIndex = years.indexOf(selectedYear);
    // if (selectedYearIndex >= years.length) return;

    // // now we know selected year is not the last one
    // final nextYearIndex = selectedYearIndex + 1;
    // final nextYear = years[nextYearIndex];

    // final newSelectedBudget = state.selectedBudget;
    // final newSelectedYear = nextYear;
    // final newYears = _monthDailyBudgetsSelectorControllerValue.years;
    // final newSelectedYearBudgets =
    //     _monthDailyBudgetsSelectorControllerValue.getBudgetsForYear(nextYear);

    // state = SetMonthDailyBudgetControllerStateDataSelections(
    //   selectedBudget: newSelectedBudget,
    //   selectedYear: newSelectedYear,
    //   years: newYears,
    //   selectedYearBudgets: newSelectedYearBudgets,
    // );
  }

  // on previous year
  void onSetPrevYear() {
    final SetMonthDailyBudgetControllerStateData oldState = state;

    switch (oldState) {
      case SetMonthDailyBudgetControllerStateDataNoBudgetsProvided():
        return;
      case SetMonthDailyBudgetControllerStateDataSelections():
        final years = _monthDailyBudgetsSelectorControllerValue.years;

        final selectedYear = oldState.selectedYear;

        final selectedYearIndex = years.indexOf(selectedYear);

        // if it is first element, return
        if (selectedYearIndex == 0) return;

        // now it is not first element
        final prevYearIndex = selectedYearIndex - 1;
        final prevYear = years[prevYearIndex];

        final newSelectedBudget = oldState.selectedBudget;
        final newSelectedYear = prevYear;
        final newYears = _monthDailyBudgetsSelectorControllerValue.years;
        final newSelectedYearBudgets = _monthDailyBudgetsSelectorControllerValue
            .getBudgetsForYear(prevYear);

        state = SetMonthDailyBudgetControllerStateDataSelections(
          selectedBudget: newSelectedBudget,
          selectedYear: newSelectedYear,
          years: newYears,
          selectedYearBudgets: newSelectedYearBudgets,
        );
    }
  }
}

class What {
  final int a = 1;
}
