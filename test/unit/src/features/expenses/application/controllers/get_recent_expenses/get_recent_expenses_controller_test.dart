import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/get_recent_expenses/get_recent_expenses_controller.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/reports/application/controllers/get_current_month_balances/get_current_month_balances_controller.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockExpensesRepository expensesRepository = _MockExpensesRepository();

  final _MockListener<AsyncValue<GetRecentExpensesControllerStateData>>
      listener =
      _MockListener<AsyncValue<GetRecentExpensesControllerStateData>>();

  setUpAll(() {
    registerFallbackValue(
        AsyncValue.data(_FakeGetRecentExpensesControllerStateData()));
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
    GetRecentExpensesController,
    () {
      group(
        "onLoadExpenses()",
        () {
          test(
            "given [ExpensesRepository].getExpenses throws"
            "when [.onLoadBalances()] is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              when(() => expensesRepository.getExpenses(
                  filter: any(named: "filter"))).thenAnswer((_) async => []);

              // complete initial .build() call
              await container.read(getRecentExpensesControllerProvider.future);

              // given
              when(() => expensesRepository.getExpenses(
                  filter: any(named: "filter"))).thenThrow(Exception("Error"));

              // when
              container.listen(
                getRecentExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );

              await container
                  .read(getRecentExpensesControllerProvider.notifier)
                  .onLoadExpenses();

              // then

              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.data(
                        GetRecentExpensesControllerStateData(
                          expenses: [],
                        ),
                      ),
                    ),
                () => listener(
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.data(
                        GetRecentExpensesControllerStateData(
                          expenses: [],
                        ),
                      ),
                      any(
                        that: isA<
                            AsyncLoading<
                                GetRecentExpensesControllerStateData>>(),
                      ),
                    ),
                () => listener(
                      any(
                        that: isA<
                            AsyncLoading<
                                GetRecentExpensesControllerStateData>>(),
                      ),
                      any(
                        that: isA<
                            AsyncError<GetRecentExpensesControllerStateData>>(),
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
            "given [ExpensesRepository].getExpenses returns normally"
            "when [.onLoadBalances()] is called"
            "then should emit states in particular order",
            () async {
              // setup
              final List<ExpenseModel> expenses = List.generate(
                2,
                (i) => ExpenseModel(
                  id: i + 1,
                  date: DateTime.now().add(Duration(seconds: i)),
                  amount: 100,
                  category: const CategoryModel(id: 1, name: "name"),
                ),
              );
              final ProviderContainer container = ProviderContainer();

              when(() => expensesRepository.getExpenses(
                  filter: any(named: "filter"))).thenAnswer((_) async => []);

              // complete initial .build() call
              await container.read(getRecentExpensesControllerProvider.future);

              // given
              when(() => expensesRepository.getExpenses(
                      filter: any(named: "filter")))
                  .thenAnswer((_) async => expenses);

              // when
              container.listen(
                getRecentExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );

              await container
                  .read(getRecentExpensesControllerProvider.notifier)
                  .onLoadExpenses();

              // then

              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.data(
                        GetRecentExpensesControllerStateData(
                          expenses: [],
                        ),
                      ),
                    ),
                () => listener(
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.data(
                        GetRecentExpensesControllerStateData(
                          expenses: [],
                        ),
                      ),
                      any(
                        that: isA<
                            AsyncLoading<
                                GetRecentExpensesControllerStateData>>(),
                      ),
                    ),
                () => listener(
                      any(
                        that: isA<
                            AsyncLoading<
                                GetRecentExpensesControllerStateData>>(),
                      ),
                      AsyncValue<GetRecentExpensesControllerStateData>.data(
                          GetRecentExpensesControllerStateData(
                        expenses: expenses,
                      )),
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
      group(
        ".build()",
        () {
          test(
            "given [ExpensesRepository].getExpenses throws"
            "when [GetRecentExpensesController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => expensesRepository.getExpenses(
                  filter: any(named: "filter"))).thenThrow(Exception("Error"));

              // when
              container.listen(
                getRecentExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.loading(),
                    ),
                () => listener(
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.loading(),
                      any(
                        // TODO no really need to check if error and stack trace are there with having - because its part of the riverpod package
                        that: isA<
                            AsyncError<GetRecentExpensesControllerStateData>>(),
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
            "given [ExpensesRepository].getExpenses returns successfully"
            "when [GetRecentExpensesController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final List<ExpenseModel> expenses = List.generate(
                2,
                (i) => ExpenseModel(
                  id: i + 1,
                  date: DateTime.now().add(Duration(seconds: i)),
                  amount: 100,
                  category: const CategoryModel(id: 1, name: "name"),
                ),
              );
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => expensesRepository.getExpenses(
                      filter: any(named: "filter")))
                  .thenAnswer((_) async => expenses);

              // when
              container.listen(
                getRecentExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.loading(),
                    ),
                () => listener(
                      const AsyncValue<
                          GetRecentExpensesControllerStateData>.loading(),
                      AsyncValue<GetRecentExpensesControllerStateData>.data(
                        GetRecentExpensesControllerStateData(
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
        },
      );
    },
  );
}

class _MockExpensesRepository extends Mock implements ExpensesRepository {}

class _MockListener<T> extends Mock {
  void call(T? oldState, T newState);
}

class _FakeGetRecentExpensesControllerStateData extends Fake
    implements GetRecentExpensesControllerStateData {}

class _FakeGetExpensesFilterValue extends Fake
    implements GetExpensesFilterValue {}
