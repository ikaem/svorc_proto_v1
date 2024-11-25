import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/get_existing_month_daily_budgets/get_existing_month_daily_budgets_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockPeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  final _MockListener<
          AsyncValue<GetExistingMonthDailyBudgetsControllerStateData>>
      listener = _MockListener<
          AsyncValue<GetExistingMonthDailyBudgetsControllerStateData>>();

  setUpAll(() {
    getIt.registerSingleton<PeriodDailyBudgetsRepository>(
      periodDailyBudgetsRepository,
    );
  });

  setUpAll(() {
    registerFallbackValue(Period.month);
    registerFallbackValue(AsyncValue.data(
        _FakeGetExistingMonthDailyBudgetsControllerStateData()));
  });

  tearDown(() {
    reset(periodDailyBudgetsRepository);
    reset(listener);
  });

  group(
    GetExistingMonthDailyBudgetsController,
    () {
      group(
        "onLoadBudgets",
        () {
          test(
            "given [PeriodDailyBudgetsRepository].getExpenses getPeriodDailyBudgetsByPeriod"
            "when [.onLoadBudgets()] is called"
            "then should emit states in particular order",
            () async {
              // setup

              // given

              // when

              // then

              // cleanup
            },
          );
        },
      );
      group(
        ".build()",
        () {
          test(
            "given [PeriodDailyBudgetsRepository].getPeriodDailyBudgetsByPeriod throws"
            "when [GetExistingMonthDailyBudgetsController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(
                () =>
                    periodDailyBudgetsRepository.getPeriodDailyBudgetsByPeriod(
                  period: any(named: "period"),
                ),
              ).thenThrow(Exception("error"));

              // when
              container.listen(
                getExistingMonthDailyBudgetsControllerProvider,
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          GetExistingMonthDailyBudgetsControllerStateData>.loading(),
                    ),
                () => listener(
                      const AsyncValue<
                          GetExistingMonthDailyBudgetsControllerStateData>.loading(),
                      any(
                          that: isA<
                              AsyncError<
                                  GetExistingMonthDailyBudgetsControllerStateData>>()),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );

          test(
            "given [PeriodDailyBudgetsRepository].getPeriodDailyBudgetsByPeriod returns normally"
            "when [GetExistingMonthDailyBudgetsController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final List<PeriodDailyBudgetModel> budgets = List.generate(
                  3,
                  (i) => PeriodDailyBudgetModel(
                        id: i,
                        period: Period.month,
                        periodEnd: DateTime.now(),
                        periodStart: DateTime.now(),
                        amount: 100,
                      ));

              final ProviderContainer container = ProviderContainer();

              // given
              when(
                () =>
                    periodDailyBudgetsRepository.getPeriodDailyBudgetsByPeriod(
                  period: any(named: "period"),
                ),
              ).thenAnswer((_) async => budgets);

              // when
              container.listen(
                getExistingMonthDailyBudgetsControllerProvider,
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          GetExistingMonthDailyBudgetsControllerStateData>.loading(),
                    ),
                () => listener(
                      const AsyncValue<
                          GetExistingMonthDailyBudgetsControllerStateData>.loading(),
                      AsyncValue<
                          GetExistingMonthDailyBudgetsControllerStateData>.data(
                        GetExistingMonthDailyBudgetsControllerStateData(
                          existingMonthDailyBudgets: budgets,
                        ),
                      ),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );
        },
      );
    },
  );
}

class _MockPeriodDailyBudgetsRepository extends Mock
    implements PeriodDailyBudgetsRepository {}

class _MockListener<T> extends Mock {
  void call(T? oldState, T newState);
}

class _FakeGetExistingMonthDailyBudgetsControllerStateData extends Fake
    implements GetExistingMonthDailyBudgetsControllerStateData {}
