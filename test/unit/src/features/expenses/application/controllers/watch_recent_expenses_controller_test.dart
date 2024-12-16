import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/watch_recent_expenses/watch_recent_expenses_controller.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
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
              final captured = verifyInOrder([
                () => listener(
                      captureAny(),
                      captureAny(),
                    ),
                () => listener(
                      captureAny(),
                      captureAny(),
                    ),
                // () => listener(
                //       captureAny(),
                //       captureAny(),
                //     ),
              ]).captured;

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

  // test initial state - initial values in stream

  // test if stream emits error

  // test that subscription is cacncelled somehow - maybe mark it as visible for testing - but how to close provider manually, and then check if subscriptiion is cancelled

  // test when stram changes - just - maybe have some delay?
// TODO testing only -----------
  test(
    "given <pre-condition to the test>"
    "when <behavior we are specifying>"
    "then should <state we expect to happen>",
    () async {
      // setup

      final stream = generateDelayedStream();

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

Stream<List<ExpenseModel>> generateDelayedStream() async* {
  final firstBatch = expenses.sublist(0, 3);
  final secondBatch = expenses.sublist(0, 5);

  yield firstBatch;

  // await Future.delayed(const Duration(seconds: 1));

  yield secondBatch;

  // throw
  // throw Exception("Error");
}
