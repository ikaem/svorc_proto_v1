import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

part "month_daily_budgets_selector_controller_state_data.dart";
part "month_daily_budgets_selector_controller.g.dart";
part "month_daily_budgets_selector_controller_value.dart";

@riverpod
class MonthDailyBudgetsSelectorController
    extends _$MonthDailyBudgetsSelectorController {
  // TODO not sure - maybe it can

  late final _MonthDailyBudgetsSelectorControllerValue
      _monthDailyBudgetsSelectorControllerValue;

// TODO no need to be async value - we will always have actual data
  @override
  MonthDailyBudgetsSelectorControllerStateData build(
    List<PeriodDailyBudgetModel> budgets,
  ) {
    // final Existing
    _monthDailyBudgetsSelectorControllerValue =
        _MonthDailyBudgetsSelectorControllerValue(
      budgets: budgets,
    );

    final MonthDailyBudgetsSelectorControllerStateData stateData =
        MonthDailyBudgetsSelectorControllerStateData(
      selectedBudget: _monthDailyBudgetsSelectorControllerValue.thisMonthBudget,
      selectedYear: _monthDailyBudgetsSelectorControllerValue
          .thisMonthBudget.periodStart.year,
      years: _monthDailyBudgetsSelectorControllerValue.years,
      selectedYearBudgets: _monthDailyBudgetsSelectorControllerValue
          .getBudgetsForYear(_monthDailyBudgetsSelectorControllerValue
              .thisMonthBudget.periodStart.year),
    );

    return stateData;
  }

  // on set budget
  void onSetBudget(PeriodDailyBudgetModel budget) {
    final newSelectedBudget = budget;
    final newSelectedYear = budget.periodStart.year;
    final newYears = _monthDailyBudgetsSelectorControllerValue.years;
    final newSelectedYearBudgets = _monthDailyBudgetsSelectorControllerValue
        .getBudgetsForYear(newSelectedYear);

    state = MonthDailyBudgetsSelectorControllerStateData(
      selectedBudget: newSelectedBudget,
      selectedYear: newSelectedYear,
      years: newYears,
      selectedYearBudgets: newSelectedYearBudgets,
    );
  }

  // on set year
  void onSetYear(int year) {
    final newSelectedBudget = state.selectedBudget;
    final newSelectedYear = year;
    final newYears = _monthDailyBudgetsSelectorControllerValue.years;
    final newSelectedYearBudgets =
        _monthDailyBudgetsSelectorControllerValue.getBudgetsForYear(year);

    state = MonthDailyBudgetsSelectorControllerStateData(
      selectedBudget: newSelectedBudget,
      selectedYear: newSelectedYear,
      years: newYears,
      selectedYearBudgets: newSelectedYearBudgets,
    );
  }

  // on next year
  void onSetNextYear() {
    final years = _monthDailyBudgetsSelectorControllerValue.years;

    final selectedYear = state.selectedYear;

    // check if index of current year is bigger than lenght of years
    // or we can just check if it is the last element
    final selectedYearIndex = years.indexOf(selectedYear);
    if (selectedYearIndex >= years.length) return;

    // now we know selected year is not the last one
    final nextYearIndex = selectedYearIndex + 1;
    final nextYear = years[nextYearIndex];

    final newSelectedBudget = state.selectedBudget;
    final newSelectedYear = nextYear;
    final newYears = _monthDailyBudgetsSelectorControllerValue.years;
    final newSelectedYearBudgets =
        _monthDailyBudgetsSelectorControllerValue.getBudgetsForYear(nextYear);

    state = MonthDailyBudgetsSelectorControllerStateData(
      selectedBudget: newSelectedBudget,
      selectedYear: newSelectedYear,
      years: newYears,
      selectedYearBudgets: newSelectedYearBudgets,
    );
  }

  // on previous year
  void onSetPrevYear() {
    final years = _monthDailyBudgetsSelectorControllerValue.years;

    final selectedYear = state.selectedYear;

    final selectedYearIndex = years.indexOf(selectedYear);

    // if it is first element, return
    if (selectedYearIndex == 0) return;

    // now it is not first element
    final prevYearIndex = selectedYearIndex - 1;
    final prevYear = years[prevYearIndex];

    final newSelectedBudget = state.selectedBudget;
    final newSelectedYear = prevYear;
    final newYears = _monthDailyBudgetsSelectorControllerValue.years;
    final newSelectedYearBudgets =
        _monthDailyBudgetsSelectorControllerValue.getBudgetsForYear(prevYear);

    state = MonthDailyBudgetsSelectorControllerStateData(
      selectedBudget: newSelectedBudget,
      selectedYear: newSelectedYear,
      years: newYears,
      selectedYearBudgets: newSelectedYearBudgets,
    );
  }
}
