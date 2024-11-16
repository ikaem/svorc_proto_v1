import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/create_month_daily_budget/create_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/values/new_period_daily_budget_local_value.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockPeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  final _MockListener<AsyncValue<CreateMonthDailyBudgetControllerState?>>
      listener =
      _MockListener<AsyncValue<CreateMonthDailyBudgetControllerState?>>();

  setUpAll(() {
    getIt.registerSingleton<PeriodDailyBudgetsRepository>(
        periodDailyBudgetsRepository);
  });

  setUpAll(() {
    registerFallbackValue(
        AsyncValue.data(_FakeCreateMonthDailyBudgetControllerState()));
    registerFallbackValue(_FakeNewPeriodDailyBudgetLocalValue());
  });

  tearDown(() {
    reset(periodDailyBudgetsRepository);
    reset(listener);
  });

  group(CreateMonthDailyBudgetController, () {
    group(
      ".build()",
      () {
        test(
          "given nothing in particular"
          "when [CreateMonthDailyBudgetController] is built"
          "then should emit expected state",
          () async {
            // setup
            final ProviderContainer container = ProviderContainer();

            // given

            // when
            final AsyncValue<CreateMonthDailyBudgetControllerState?> state =
                container.read(createMonthDailyBudgetControllerProvider);

            // then

            expect(
                state,
                const AsyncValue<CreateMonthDailyBudgetControllerState?>.data(
                    null));

            // cleanup
            addTearDown(() {
              container.dispose();
            });
          },
        );
      },
    );

    group(
      ".onCreateBudget",
      () {
        test(
          "given [PeriodDailyBudgetsRepository].createPeriodDailyBudget() throws an error"
          "when [CreateMonthDailyBudgetController].onCreateBudget() is called"
          "then should emit states in particular order",
          () async {
            // setup
            final ProviderContainer container = ProviderContainer();

            // given
            when(
              () => periodDailyBudgetsRepository.createPeriodDailyBudget(
                newPeriodDailyBudget: any(named: "newPeriodDailyBudget"),
              ),
            ).thenThrow(Exception("error"));

            // when
            container.listen(
              createMonthDailyBudgetControllerProvider,
              listener.call,
              fireImmediately: true,
            );
            // await initial state
            await Future<void>.delayed(Duration.zero);

            await container
                .read(createMonthDailyBudgetControllerProvider.notifier)
                .onCreateBudget(
                  date: DateTime.now(),
                  amount: 100,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.data(null),
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.loading(),
                    any(
                      that: isA<
                          AsyncError<CreateMonthDailyBudgetControllerState?>>(),
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
          "given [PeriodDailyBudgetsRepository].createPeriodDailyBudget() returns an id"
          "when [CreateMonthDailyBudgetController].onCreateBudget() is called"
          "then should emit states in particular order",
          () async {
            // setup
            final ProviderContainer container = ProviderContainer();

            // given
            when(
              () => periodDailyBudgetsRepository.createPeriodDailyBudget(
                newPeriodDailyBudget: any(named: "newPeriodDailyBudget"),
              ),
            ).thenAnswer((_) async => 1);

            // when
            container.listen(
              createMonthDailyBudgetControllerProvider,
              listener.call,
              fireImmediately: true,
            );
            // await initial state
            await Future<void>.delayed(Duration.zero);

            await container
                .read(createMonthDailyBudgetControllerProvider.notifier)
                .onCreateBudget(
                  date: DateTime.now(),
                  amount: 100,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.data(null),
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.loading(),
                    const AsyncValue<
                        CreateMonthDailyBudgetControllerState?>.data(
                      CreateMonthDailyBudgetControllerState(
                          createdDailyBudgetId: 1),
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
  });
}

class _MockPeriodDailyBudgetsRepository extends Mock
    implements PeriodDailyBudgetsRepository {}

class _MockListener<T> extends Mock {
  void call(T? previous, T state);
}

class _FakeCreateMonthDailyBudgetControllerState extends Fake
    implements CreateMonthDailyBudgetControllerState {}

class _FakeNewPeriodDailyBudgetLocalValue extends Fake
    implements NewPeriodDailyBudgetLocalValue {}
