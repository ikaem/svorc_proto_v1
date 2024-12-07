import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/set_month_daily_budget/set_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

void main() {
  final _MockListener<SetMonthDailyBudgetControllerStateData> mockListener =
      _MockListener<SetMonthDailyBudgetControllerStateData>();

  setUpAll(() {
    registerFallbackValue(
        SetMonthDailyBudgetControllerStateDataNoBudgetsProvided());
  });

  tearDown(() {
    reset(mockListener);
  });
  group(
    SetMonthDailyBudgetController,
    () {
      group(
        ".build()",
        () {
          test(
            "given empty list of [PeriodDailyBudgetModel] "
            "when [SetMonthDailyBudgetController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              final budgets = <PeriodDailyBudgetModel>[];

              // when
              final SetMonthDailyBudgetControllerProvider providerInstance =
                  setMonthDailyBudgetControllerProvider(budgets);
              container.listen(
                providerInstance,
                mockListener.call,
                fireImmediately: true,
              );

              // then
              // TODO we can do this as well - but i want to see all states - to make sure there is only one emitted
              // final state =
              //     container.read(setMonthDailyBudgetControllerProvider([]));
              verifyInOrder([
                () => mockListener(
                      null,
                      SetMonthDailyBudgetControllerStateDataNoBudgetsProvided(),
                    ),
              ]);
              verifyNoMoreInteractions(
                mockListener,
              );

              // cleanup
              addTearDown(
                () {
                  container.dispose();
                },
              );
            },
          );

          test(
            "given NON-empty list of [PeriodDailyBudgetModel] "
            "when [SetMonthDailyBudgetController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              final List<PeriodDailyBudgetModel> budgets = List.generate(
                12,
                (i) {
                  final month = i + 1;
                  final date = DateTime(DateTime.now().year, month, 1);
                  final extremes =
                      PeriodExtremesMomentsCalculator.calculateMonthMoments(
                          monthIndex: date.month, year: date.year);
                  return PeriodDailyBudgetModel(
                    id: i + 1,
                    periodStart: extremes.periodStart,
                    periodEnd: extremes.periodEnd,
                    amount: 1000,
                    period: Period.month,
                  );
                },
              );

              // when
              final SetMonthDailyBudgetControllerProvider providerInstance =
                  setMonthDailyBudgetControllerProvider(budgets);
              container.listen(
                providerInstance,
                mockListener.call,
                fireImmediately: true,
              );

              // then
              final SetMonthDailyBudgetControllerStateDataSelections
                  expectedStateData =
                  SetMonthDailyBudgetControllerStateDataSelections(
                selectedBudget: budgets.firstWhere(
                  (element) =>
                      element.periodStart.month == DateTime.now().month,
                ),
                selectedYear: budgets
                    .firstWhere(
                      (element) =>
                          element.periodStart.month == DateTime.now().month,
                    )
                    .periodStart
                    .year,
                years: budgets.map((e) => e.periodStart.year).toSet().toList(),
                selectedYearBudgets: budgets,
              );

              verifyInOrder([
                () => mockListener(
                      null,
                      expectedStateData,
                    ),
              ]);
              verifyNoMoreInteractions(
                mockListener,
              );

              // cleanup
              addTearDown(
                () {
                  container.dispose();
                },
              );
            },
          );
        },
      );

      group(
        "onSetBudget()",
        () {
          test(
            "given [PeriodDailyBudgetModel] "
            "when [onSetBudget] is called"
            "then should emit particular state",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              final List<PeriodDailyBudgetModel> budgets = List.generate(
                12,
                (i) {
                  final month = i + 1;
                  final date = DateTime(DateTime.now().year, month, 1);
                  final extremes =
                      PeriodExtremesMomentsCalculator.calculateMonthMoments(
                          monthIndex: date.month, year: date.year);
                  return PeriodDailyBudgetModel(
                    id: i + 1,
                    periodStart: extremes.periodStart,
                    periodEnd: extremes.periodEnd,
                    amount: 1000,
                    period: Period.month,
                  );
                },
              );
              final SetMonthDailyBudgetControllerProvider providerInstance =
                  setMonthDailyBudgetControllerProvider(budgets);

              // TODO testing with reading subscription
              final ProviderSubscription<SetMonthDailyBudgetControllerStateData>
                  subscription = container.listen(
                providerInstance,
                (prevState, newState) {},
                // TODO not needed
                // fireImmediately: true,
              );

              // given
              final budget = budgets.firstWhere(
                (element) => element.periodStart.month == 2,
              );

              // when
              container.read(providerInstance.notifier).onSetBudget(
                    budget,
                  );

              final SetMonthDailyBudgetControllerStateData state =
                  subscription.read();

              final SetMonthDailyBudgetControllerStateDataSelections
                  expectedState =
                  SetMonthDailyBudgetControllerStateDataSelections(
                selectedBudget: budget,
                selectedYear: budget.periodStart.year,
                years: budgets.map((e) => e.periodStart.year).toSet().toList(),
                selectedYearBudgets: budgets,
              );

              // then
              expect(
                state,
                equals(expectedState),
              );

              // cleanup
              addTearDown(
                () {
                  container.dispose();
                },
              );
            },
          );
        },
      );

      group(
        "onSetYear()",
        () {
          test(
            "given [year] "
            "when [onSetYear] is called"
            "then should emit particular state",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              final List<PeriodDailyBudgetModel> thisYearBudgets =
                  List.generate(
                12,
                (i) {
                  final month = i + 1;
                  final date = DateTime(DateTime.now().year, month, 1);
                  final extremes =
                      PeriodExtremesMomentsCalculator.calculateMonthMoments(
                          monthIndex: date.month, year: date.year);
                  return PeriodDailyBudgetModel(
                    id: i + 1,
                    periodStart: extremes.periodStart,
                    periodEnd: extremes.periodEnd,
                    amount: 1000,
                    period: Period.month,
                  );
                },
              );

              final List<PeriodDailyBudgetModel> nextYearBudgets =
                  List.generate(
                12,
                (i) {
                  final month = i + 1;
                  final date = DateTime(DateTime.now().year + 1, month, 1);
                  final extremes =
                      PeriodExtremesMomentsCalculator.calculateMonthMoments(
                          monthIndex: date.month, year: date.year);
                  return PeriodDailyBudgetModel(
                    id: i + 1,
                    periodStart: extremes.periodStart,
                    periodEnd: extremes.periodEnd,
                    amount: 1000,
                    period: Period.month,
                  );
                },
              );

              final List<PeriodDailyBudgetModel> budgets = [
                ...thisYearBudgets,
                ...nextYearBudgets,
              ];

              final SetMonthDailyBudgetControllerProvider providerInstance =
                  setMonthDailyBudgetControllerProvider(budgets);

              // TODO testing with reading subscription
              final ProviderSubscription<SetMonthDailyBudgetControllerStateData>
                  subscription = container.listen(
                providerInstance,
                (prevState, newState) {},
                // TODO not needed
                // fireImmediately: true,
              );

              // given
              final year = DateTime.now().year + 1;

              // when
              container.read(providerInstance.notifier).onSetYear(
                    year,
                  );

              // then
              final expectedState =
                  SetMonthDailyBudgetControllerStateDataSelections(
                selectedBudget: budgets.firstWhere(
                  (element) =>
                      element.periodStart.month == DateTime.now().month,
                ),
                selectedYear: year,
                years: budgets.map((e) => e.periodStart.year).toSet().toList(),
                selectedYearBudgets: nextYearBudgets,
              );

              final SetMonthDailyBudgetControllerStateData state =
                  subscription.read();

              expect(
                state,
                equals(expectedState),
              );

              // cleanup
              addTearDown(
                () {
                  container.dispose();
                },
              );
            },
          );
        },
      );

      // TODO missing tests for on set next year
      // TODO missing tests for on set prev year
    },
  );
}

class _MockListener<T> extends Mock {
  void call(T? prevState, T newState);
}

// class _FakeSetMonthDailyBudgetControllerStateData extends Fake
//     implements SetMonthDailyBudgetControllerStateData {}

class _FakeSetMonthDailyBudgetControllerStateDataNoBudgetsProvided extends Fake
    implements SetMonthDailyBudgetControllerStateDataNoBudgetsProvided {}
