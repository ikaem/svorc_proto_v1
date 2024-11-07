import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/get_month_daily_budget/get_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockPeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  final _MockListener listener =
      _MockListener<GetMonthDailyBudgetControllerState>();

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
        ".onLoadBudget()",
        () {
          test(
            "given [PeriodDailyBudgetsRepository].getPeriodDailyBudgetByDateAndPeriod throws"
            "when [.onLoadBudget()] is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              when(() => periodDailyBudgetsRepository
                      .getPeriodDailyBudgetByDateAndPeriod(
                    date: any(named: "date"),
                    period: any(named: "period"),
                  )).thenAnswer((_) async => null);

              // final provider = getMonthDailyBudgetControllerProvider()
              final provider =
                  getMonthDailyBudgetControllerProvider(DateTime.now());
              await Future.delayed(Duration.zero);

              // complete initial .build() call
              await container.read(provider.future);

              // given
              when(() => periodDailyBudgetsRepository
                      .getPeriodDailyBudgetByDateAndPeriod(
                    date: any(named: "date"),
                    period: any(named: "period"),
                  )).thenThrow(Exception("error"));

              // when
              // listen to the provider
              container.listen(
                provider,
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // call .onLoadBudget()
              await container.read(provider.notifier).onLoadBudget();

              // TODO test
              // final captured = verifyInOrder([
              //   () => listener(captureAny(), captureAny()),
              //   () => listener(captureAny(), captureAny()),
              //   () => listener(captureAny(), captureAny()),
              // ]).captured;

              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<GetMonthDailyBudgetControllerState>.data(
                        GetMonthDailyBudgetControllerState(
                          null,
                        ),
                      ),
                    ),
                () => listener(
                      const AsyncValue<GetMonthDailyBudgetControllerState>.data(
                        GetMonthDailyBudgetControllerState(
                          null,
                        ),
                      ),
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
                    ),
              ]);

              print("captured");

              // verifyInOrder(
              //   [
              //     () => listener(
              //           null,
              //           const AsyncValue<
              //               GetMonthDailyBudgetControllerState>.data(
              //             GetMonthDailyBudgetControllerState(
              //               null,
              //             ),
              //           ),
              //         ),
              //     () => listener(
              //           const AsyncValue<
              //               GetMonthDailyBudgetControllerState>.data(
              //             GetMonthDailyBudgetControllerState(
              //               null,
              //             ),
              //           ),
              //           const AsyncValue<
              //               GetMonthDailyBudgetControllerState>.loading(),
              //         ),
              //     () => listener(
              //           const AsyncValue<
              //               GetMonthDailyBudgetControllerState>.loading(),
              //           any(
              //               that: isA<
              //                       AsyncError<
              //                           GetMonthDailyBudgetControllerState>>()
              //                   .having(
              //             (e) {
              //               return e.error;
              //             },
              //             "error",
              //             isA<Exception>(),
              //           ).having(
              //             (e) {
              //               return e.stackTrace;
              //             },
              //             "stackTrace",
              //             isA<StackTrace>(),
              //           )),
              //         ),
              //   ],
              // );

              // verifyNoMoreInteractions(listener);

              // print(captured);

              // then
              // verifyInOrder([
              //   () => listener(
              //         const AsyncValue<GetMonthDailyBudgetControllerState>.data(
              //           GetMonthDailyBudgetControllerState(
              //             null,
              //           ),
              //         ),
              //         const AsyncValue<
              //             GetMonthDailyBudgetControllerState>.loading(),
              //       ),
              //   () => listener(
              //         const AsyncValue<
              //             GetMonthDailyBudgetControllerState>.loading(),
              //         any(
              //             that: isA<
              //                     AsyncError<
              //                         GetMonthDailyBudgetControllerState>>()
              //                 .having(
              //           (e) {
              //             return e.error;
              //           },
              //           "error",
              //           isA<Exception>(),
              //         ).having(
              //           (e) {
              //             return e.stackTrace;
              //           },
              //           "stackTrace",
              //           isA<StackTrace>(),
              //         )),
              //       )
              // ]);
              // verifyNoMoreInteractions(listener);

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
                getMonthDailyBudgetControllerProvider(
                  DateTime.now(),
                ),
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

          test(
            "given [PeriodDailyBudgetsRepository].getPeriodDailyBudgetByDateAndPeriod returns null"
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
                  )).thenAnswer((_) async => null);

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
                      const AsyncValue<GetMonthDailyBudgetControllerState>.data(
                        GetMonthDailyBudgetControllerState(
                          null,
                        ),
                      ),
                    ),
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
          test(
            "given [PeriodDailyBudgetsRepository].getPeriodDailyBudgetByDateAndPeriod returns [PeriodDailyBudgetModel]"
            "when [GetMonthDailyBudgetController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final PeriodDailyBudgetModel periodDailyBudgetModel =
                  PeriodDailyBudgetModel(
                id: 1,
                periodStart: DateTime.now(),
                periodEnd: DateTime.now(),
                amount: 100,
                period: Period.month,
              );
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => periodDailyBudgetsRepository
                      .getPeriodDailyBudgetByDateAndPeriod(
                    date: any(named: "date"),
                    period: any(named: "period"),
                  )).thenAnswer(
                (_) async => periodDailyBudgetModel,
              );

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
                      AsyncValue<GetMonthDailyBudgetControllerState>.data(
                        GetMonthDailyBudgetControllerState(
                          periodDailyBudgetModel,
                        ),
                      ),
                    ),
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
