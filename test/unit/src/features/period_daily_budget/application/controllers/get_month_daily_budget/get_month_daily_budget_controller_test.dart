import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/get_month_daily_budget/get_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockPeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  final _MockListener listener = _MockListener();

  setUpAll(() {
    registerFallbackValue(_FakeGetMonthDailyBudgetControllerState());
    registerFallbackValue(Period.month);
  });

  setUpAll(
    () {
      // registerFallbackValue(_FakeGetMonthDailyBudgetControllerState());
      getIt.registerSingleton<PeriodDailyBudgetsRepository>(
          periodDailyBudgetsRepository);
    },
  );

  tearDown(() {
    reset(periodDailyBudgetsRepository);
    reset(listener);
  });

  group(
    GetMonthDailyBudgetController,
    () {
      group(
        ".build()",
        () {
          test(
            "given [PeriodDailyBudgetsRepository].getPeriodDailyBudgetByDateAndPeriod throws"
            "when [GetMonthDailyBudgetController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => periodDailyBudgetsRepository
                      .getPeriodDailyBudgetByDateAndPeriod(
                    date: any(named: "date"),
                    period: any(named: "period"),
                  )).thenThrow(Exception("error"));

              // when
              container.listen(
                getMonthDailyBudgetControllerProvider(DateTime.now()),
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          GetMonthDailyBudgetControllerState>.loading(),
                    ),
                () => listener(
                      const AsyncValue<
                          GetMonthDailyBudgetControllerState>.loading(),
                      any(
                          that: isA<
                                  AsyncError<
                                      GetMonthDailyBudgetControllerState>>()
                              .having(
                        (e) {
                          return e.error;
                        },
                        "error",
                        isA<Exception>(),
                      ).having(
                        (e) {
                          return e.stackTrace;
                        },
                        "stackTrace",
                        isA<StackTrace>(),
                      )),
                    )
              ]);
              verifyNoMoreInteractions(listener);

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
    },
  );
}

class _MockPeriodDailyBudgetsRepository extends Mock
    implements PeriodDailyBudgetsRepository {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeGetMonthDailyBudgetControllerState extends Fake
    implements GetMonthDailyBudgetControllerState {}
