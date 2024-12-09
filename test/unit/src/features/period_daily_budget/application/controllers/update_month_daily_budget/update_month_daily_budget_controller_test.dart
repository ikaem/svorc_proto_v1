import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/update_month_daily_budget/update_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockPeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  final _MockListener<AsyncValue<UpdateMonthDailyBudgetControllerStateData?>>
      listener =
      _MockListener<AsyncValue<UpdateMonthDailyBudgetControllerStateData?>>();

  setUpAll(() {
    getIt.registerSingleton<PeriodDailyBudgetsRepository>(
        periodDailyBudgetsRepository);
  });

  setUpAll(() {
    registerFallbackValue(
      AsyncValue.data(_FakeUpdateMonthDailyBudgetControllerStateData()),
    );
  });

  setUp(() {
    registerFallbackValue(_FakeUpdateMonthDailyBudgetControllerStateData());
  });

  tearDown(() {
    reset(periodDailyBudgetsRepository);
    reset(listener);
  });

  group(
    UpdateMonthDailyBudgetController,
    () {
      group(
        ".build()",
        () {
          test(
            "given nothing in particular"
            "when [UpdateMonthDailyBudgetController] is built"
            "then should emit expected state",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given

              // when
              final ProviderSubscription<
                      AsyncValue<UpdateMonthDailyBudgetControllerStateData?>>
                  subscription = container.listen(
                updateMonthDailyBudgetControllerProvider,
                (_, __) {},
                // TODO  not needed it seems
                // fireImmediately: true,
              );

              final AsyncValue<UpdateMonthDailyBudgetControllerStateData?>
                  state = subscription.read();

              // then
              expect(
                state,
                const AsyncValue<
                    UpdateMonthDailyBudgetControllerStateData?>.data(null),
              );

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );
        },
      );

      group(
        "onUpdateBudget()",
        () {
          test(
            "given [PeriodDailyBudgetsRepository].updatePeriodDailyBudget() throws"
            "when [UpdateMonthDailyBudgetController].onUpdateBudget() is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(
                () => periodDailyBudgetsRepository.updatePeriodDailyBudget(
                  amount: any(named: "amount"),
                  id: any(named: "id"),
                ),
              ).thenThrow(Exception("error"));

              // when
              container.listen(
                updateMonthDailyBudgetControllerProvider,
                listener.call,
                // TODO test if needed
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              await container
                  .read(updateMonthDailyBudgetControllerProvider.notifier)
                  .onUpdateBudget(
                    amount: 100,
                    id: 1,
                  );

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.data(
                        null,
                      ),
                    ),
                () => listener(
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.data(
                        null,
                      ),
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.loading(),
                    ),
                () => listener(
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.loading(),
                      any(
                        that: isA<
                            AsyncError<
                                UpdateMonthDailyBudgetControllerStateData?>>(),
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

          test(
            "given [PeriodDailyBudgetsRepository].updatePeriodDailyBudget() returns successfully"
            "when [UpdateMonthDailyBudgetController].onUpdateBudget() is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(
                () => periodDailyBudgetsRepository.updatePeriodDailyBudget(
                  amount: any(named: "amount"),
                  id: any(named: "id"),
                ),
              ).thenAnswer((_) async => 1);

              // when
              container.listen(
                updateMonthDailyBudgetControllerProvider,
                listener.call,
                // TODO test if needed
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              await container
                  .read(updateMonthDailyBudgetControllerProvider.notifier)
                  .onUpdateBudget(
                    amount: 100,
                    id: 1,
                  );

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.data(
                        null,
                      ),
                    ),
                () => listener(
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.data(
                        null,
                      ),
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.loading(),
                    ),
                () => listener(
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.loading(),
                      const AsyncValue<
                          UpdateMonthDailyBudgetControllerStateData?>.data(
                        UpdateMonthDailyBudgetControllerStateData(
                          updatedDailyBudgetId: 1,
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
  void call(T? previous, T current);
}

class _FakeUpdateMonthDailyBudgetControllerStateData extends Fake
    implements UpdateMonthDailyBudgetControllerStateData {}
