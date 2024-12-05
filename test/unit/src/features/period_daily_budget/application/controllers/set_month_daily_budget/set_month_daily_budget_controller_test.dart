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
                3,
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

              // verifyInOrder([
              //   () => mockListener(
              //         null,
              //         SetMonthDailyBudgetControllerStateDataNoBudgetsProvided(),
              //       ),
              // ]);
              // verifyNoMoreInteractions(
              //   mockListener,
              // );

              // cleanup
              print("cleanup");
              addTearDown(
                () {
                  container.dispose();
                },
              );
            },
          );
        },
      );
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
