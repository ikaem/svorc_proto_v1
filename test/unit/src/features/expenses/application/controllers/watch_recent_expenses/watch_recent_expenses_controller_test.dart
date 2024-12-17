import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/watch_recent_expenses/watch_recent_expenses_controller.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/get_expenses_filter_value.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final ExpensesRepository expensesRepository = _MockExpensesRepository();

  final _MockListener<AsyncValue<WatchRecentExpensesControllerStateData?>>
      listener =
      _MockListener<AsyncValue<WatchRecentExpensesControllerStateData?>>();

  setUpAll(() {
    registerFallbackValue(
        AsyncValue.data(_FakeWatchRecentExpensesControllerStateData()));
    registerFallbackValue(_FakeGetExpensesFilterValue());
  });

  setUpAll(() {
    getIt.registerSingleton<ExpensesRepository>(expensesRepository);
  });

  tearDown(() {
    reset(expensesRepository);
    reset(listener);
  });

  group(
    WatchRecentExpensesController,
    () {
      group(
        ".build()",
        () {
          test(
            "given [ExpensesRepository].watchExpenses emits data"
            "when [WatchRecentExpensesController].build() is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              final stream = Stream.value(expenses);

              when(() => expensesRepository.watchExpenses(
                  filter: any(named: "filter"))).thenAnswer((_) => stream);

              // when
              container.listen(
                watchRecentExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncData<WatchRecentExpensesControllerStateData?>(
                        null,
                      ),
                    ),
                () => listener(
                      const AsyncData<WatchRecentExpensesControllerStateData?>(
                        null,
                      ),
                      AsyncData<WatchRecentExpensesControllerStateData?>(
                        WatchRecentExpensesControllerStateData(
                          expenses: expenses,
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

          // test when stram changes - just - maybe have some delay?

          test(
            "given [WatchRecentExpensesController] has already emitted state with list of [ExpenseModel]"
            "when [ExpensesRepository].watchExpenses emits new data"
            "then should have the [WatchRecentExpensesController] emit new state",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              final Stream<List<ExpenseModel>> stream =
                  _generateDelayedStream();

              when(() => expensesRepository.watchExpenses(
                  filter: any(named: "filter"))).thenAnswer((_) => stream);

              // when
              container.listen(
                watchRecentExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );

              await Future.delayed(const Duration(milliseconds: 200));

              // then
              final List<ExpenseModel> firstBatch = expenses.sublist(0, 3);
              final List<ExpenseModel> secondBatch = expenses.sublist(0, 5);

              // final captured = verifyInOrder([
              //   () => listener(
              //         captureAny(),
              //         captureAny(),
              //       ),
              //   () => listener(
              //         captureAny(),
              //         captureAny(),
              //       ),
              //   () => listener(
              //         captureAny(),
              //         captureAny(),
              //       ),
              // ]).captured;

              verifyInOrder([
                () => listener(
                      null,
                      const AsyncData<WatchRecentExpensesControllerStateData?>(
                        null,
                      ),
                    ),
                () => listener(
                      const AsyncData<WatchRecentExpensesControllerStateData?>(
                        null,
                      ),
                      AsyncData<WatchRecentExpensesControllerStateData?>(
                        WatchRecentExpensesControllerStateData(
                          expenses: firstBatch,
                        ),
                      ),
                    ),
                () => listener(
                      AsyncData<WatchRecentExpensesControllerStateData?>(
                        WatchRecentExpensesControllerStateData(
                          expenses: firstBatch,
                        ),
                      ),
                      AsyncData<WatchRecentExpensesControllerStateData?>(
                        WatchRecentExpensesControllerStateData(
                          expenses: secondBatch,
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

          test(
            "given [ExpensesRepository].watchExpenses emits error"
            "when [WatchRecentExpensesController].build() is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              final Stream<List<ExpenseModel>> stream = _generateDelayedStream(
                true,
              );

              when(() => expensesRepository.watchExpenses(
                  filter: any(named: "filter"))).thenAnswer((_) => stream);

              // when
              container.listen(
                watchRecentExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );

              await Future.delayed(const Duration(milliseconds: 200));

              // then
              final List<ExpenseModel> firstBatch = expenses.sublist(0, 3);

              verifyInOrder([
                () => listener(
                      null,
                      const AsyncData<WatchRecentExpensesControllerStateData?>(
                        null,
                      ),
                    ),
                () => listener(
                      const AsyncData<WatchRecentExpensesControllerStateData?>(
                        null,
                      ),
                      AsyncData<WatchRecentExpensesControllerStateData?>(
                        WatchRecentExpensesControllerStateData(
                          expenses: firstBatch,
                        ),
                      ),
                    ),
                () => listener(
                      AsyncData<WatchRecentExpensesControllerStateData?>(
                        WatchRecentExpensesControllerStateData(
                          expenses: firstBatch,
                        ),
                      ),
                      any(
                          that: isA<
                              AsyncError<
                                  WatchRecentExpensesControllerStateData?>>()),
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

  // TODO test that subscription is cacncelled somehow - maybe mark it as visible for testing - but how to close provider manually, and then check if subscriptiion is cancelled

// TODO testing only -----------
  test(
    "given <pre-condition to the test>"
    "when <behavior we are specifying>"
    "then should <state we expect to happen>",
    () async {
      // setup

      final stream = _generateDelayedStream();

      final firstBatch = expenses.sublist(0, 3);
      final secondBatch = expenses.sublist(0, 5);

      // expect(await stream.first, firstBatch);

      expectLater(
        stream,
        emitsInOrder([
          firstBatch,
          secondBatch,
        ]),
      );

      // await Future.delayed(const Duration(seconds: 1));

      // expect(await stream.first, secondBatch);

      print("done");

      // given

      // when

      // then

      // cleanup
    },
  );
}

class _MockExpensesRepository extends Mock implements ExpensesRepository {}

class _MockListener<T> extends Mock {
  void call(T? oldState, T newState);
}

class _FakeWatchRecentExpensesControllerStateData extends Fake
    implements WatchRecentExpensesControllerStateData {}

class _FakeGetExpensesFilterValue extends Fake
    implements GetExpensesFilterValue {}

// helpers

final List<ExpenseModel> expenses = List.generate(
  5,
  (index) => ExpenseModel(
    id: index + 1,
    date: DateTime.now().add(Duration(days: index)),
    amount: 100 * (index + 1),
    category: CategoryModel(
      id: index + 1,
      name: "Category $index",
    ),
  ),
);

Stream<List<ExpenseModel>> _generateDelayedStream([
  bool shouldThrow = false,
]) async* {
  final firstBatch = expenses.sublist(0, 3);
  final secondBatch = expenses.sublist(0, 5);

  yield firstBatch;

  await Future.delayed(const Duration(milliseconds: 100));

  if (shouldThrow) {
    throw Exception("Error");
  }

  yield secondBatch;
}
