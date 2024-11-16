import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/create_expense/create_expense_controller.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockExpensesRepository expensesRepository = _MockExpensesRepository();

  final _MockListener<AsyncValue<CreateExpenseControllerState>> listener =
      _MockListener<AsyncValue<CreateExpenseControllerState>>();

  setUpAll(() {
    getIt.registerSingleton<ExpensesRepository>(expensesRepository);
  });

  setUpAll(() {
    registerFallbackValue(_FakeNewExpenseLocalValue());
    registerFallbackValue(AsyncValue.data(_FakeCreateExpenseControllerState()));
  });

  tearDown(() {
    reset(expensesRepository);
    reset(listener);
  });

  group(
    CreateExpenseController,
    () {
      group(
        ".build()",
        () {
          test(
            "given nothing in particular"
            "when [CreateExpenseController] is built"
            "then should emit expected state",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given

              // when
              final AsyncValue<CreateExpenseControllerState> state =
                  container.read(createExpenseControllerProvider);

              // then
              expect(
                  state,
                  equals(const AsyncValue.data(
                    CreateExpenseControllerState(createdExpenseId: null),
                  )));

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );
        },
      );

      group(
        ".onCreateExpense()",
        () {
          test(
            "given [ExpensesRepository].createExpense() throws an error"
            "when [CreateExpenseController].onCreateExpense() is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => expensesRepository.createExpense(
                    newExpense: any(named: "newExpense"),
                  )).thenThrow(Exception("error"));

              // when
              container.listen(
                createExpenseControllerProvider,
                listener.call,
                fireImmediately: true,
              );
              // i guess await for initial state to emit
              await Future<void>.delayed(Duration.zero);

              await container
                  .read(createExpenseControllerProvider.notifier)
                  .onCreateExpense(
                    date: DateTime.now(),
                    amount: 0,
                    note: null,
                    categoryId: 0,
                  );

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<CreateExpenseControllerState>.data(
                        CreateExpenseControllerState(createdExpenseId: null),
                      ),
                    ),
                () => listener(
                      const AsyncValue<CreateExpenseControllerState>.data(
                        CreateExpenseControllerState(createdExpenseId: null),
                      ),
                      const AsyncValue<CreateExpenseControllerState>.loading(),
                    ),
                () => listener(
                      const AsyncValue<CreateExpenseControllerState>.loading(),
                      // const AsyncValue<CreateExpenseControllerState>.error(),
                      any(
                        that: isA<AsyncError<CreateExpenseControllerState>>(),
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
            "given [ExpensesRepository].createExpense() returns an id"
            "when [CreateExpenseController].onCreateExpense() returns an id"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => expensesRepository.createExpense(
                    newExpense: any(named: "newExpense"),
                  )).thenAnswer((_) async => 1);

              // when
              container.listen(
                createExpenseControllerProvider,
                listener.call,
                fireImmediately: true,
              );

              await Future<void>.delayed(Duration.zero);

              await container
                  .read(createExpenseControllerProvider.notifier)
                  .onCreateExpense(
                    date: DateTime.now(),
                    amount: 0,
                    note: null,
                    categoryId: 0,
                  );

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<CreateExpenseControllerState>.data(
                        CreateExpenseControllerState(createdExpenseId: null),
                      ),
                    ),
                () => listener(
                      const AsyncValue<CreateExpenseControllerState>.data(
                        CreateExpenseControllerState(createdExpenseId: null),
                      ),
                      const AsyncValue<CreateExpenseControllerState>.loading(),
                    ),
                () => listener(
                    const AsyncValue<CreateExpenseControllerState>.loading(),
                    // const AsyncValue<CreateExpenseControllerState>.error(),
                    // any(
                    //   that: isA<AsyncError<CreateExpenseControllerState>>(),
                    // ),
                    const AsyncValue<CreateExpenseControllerState>.data(
                      CreateExpenseControllerState(createdExpenseId: 1),
                    )),
              ]);

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

class _MockExpensesRepository extends Mock implements ExpensesRepository {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeNewExpenseLocalValue extends Fake implements NewExpenseLocalValue {}

class _FakeCreateExpenseControllerState extends Fake
    implements CreateExpenseControllerState {}
