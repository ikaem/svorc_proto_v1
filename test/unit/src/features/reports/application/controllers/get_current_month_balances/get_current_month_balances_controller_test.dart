import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/reports/application/controllers/get_current_month_balances/get_current_month_balances_controller.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/month_balances_value.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

final PeriodDailyBudgetModel currentMonthDailyBudgetModel =
    PeriodDailyBudgetModel(
  id: 1,
  periodStart: DateTime.now(),
  periodEnd: DateTime.now().add(const Duration(days: 30)),
  amount: 1000,
  period: Period.month,
);

void main() {
  final _MockExpensesRepository expensesRepository = _MockExpensesRepository();

  final _MockListener<AsyncValue<GetCurrentMonthBalancesControllerStateData>>
      listener =
      _MockListener<AsyncValue<GetCurrentMonthBalancesControllerStateData>>();

  setUpAll(() {
    registerFallbackValue(_FakeGetExpensesFilterValue());
    registerFallbackValue(
        AsyncValue.data(_FakeGetCurrentMonthBalancesControllerStateData()));
  });

  setUpAll(() {
    getIt.registerSingleton<ExpensesRepository>(expensesRepository);
  });

  tearDown(() {
    reset(expensesRepository);
    reset(listener);
  });

  group(
    GetCurrentMonthBalancesController,
    () {
      group(
        "onLoadBalances",
        () {
          test(
            "given [ExpensesRepository].getExpenses throws"
            "when [.onLoadBalances()] is called"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => expensesRepository.getExpenses(
                  filter: any(named: "filter"))).thenAnswer((_) async => []);

              final GetCurrentMonthBalancesControllerProvider provider =
                  getCurrentMonthBalancesControllerProvider(
                      currentMonthDailyBudgetModel);
              // await Future.delayed(Duration.zero);

              // complete initial .build() call
              await container.read(provider.future);

              // given
              when(() => expensesRepository.getExpenses(
                  filter: any(named: "filter"))).thenThrow(Exception("error"));

              // when
              container.listen(
                provider,
                listener.call,
                fireImmediately: true,
              );

              await container.read(provider.notifier).onLoadBalances();

              final MonthBalanceCalculationHelper calculator =
                  MonthBalanceCalculationHelper(
                monthExpenses: [],
                dailyBudget: currentMonthDailyBudgetModel.amount,
                monthDate: currentMonthDailyBudgetModel.periodStart,
              );

              final MonthBalancesValue balances = MonthBalancesValue(
                currentMonthDailyBudget: currentMonthDailyBudgetModel,
                currentWeekBalance: calculator.weekBalance,
                currentMonthBalance: calculator.monthBalance,
                currentDayBalance: calculator.todayBalance,
              );

              verifyInOrder([
                () => listener(
                      null,
                      AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.data(
                        GetCurrentMonthBalancesControllerStateData(
                          balances: balances,
                        ),
                      ),
                    ),
                () => listener(
                      AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.data(
                        GetCurrentMonthBalancesControllerStateData(
                          balances: balances,
                        ),
                      ),
                      any(
                        that: isA<
                            AsyncLoading<
                                GetCurrentMonthBalancesControllerStateData>>(),
                      ),
                    ),
                () => listener(
                      any(
                        that: isA<
                            AsyncLoading<
                                GetCurrentMonthBalancesControllerStateData>>(),
                      ),
                      any(
                        that: isA<
                                AsyncError<
                                    GetCurrentMonthBalancesControllerStateData>>()
                            .having((e) {
                          return e.error;
                        }, "error", isA<Exception>()).having(
                                (e) => e.stackTrace,
                                "stackTrace",
                                isA<StackTrace>()),
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

              // given
              when(() => expensesRepository.getExpenses(
                      filter: any(named: "filter")))
                  .thenAnswer((_) async => expenses);

              final GetCurrentMonthBalancesControllerProvider provider =
                  getCurrentMonthBalancesControllerProvider(
                      currentMonthDailyBudgetModel);
              // await Future.delayed(Duration.zero);

              // complete initial .build() call
              await container.read(provider.future);

              // given

              // when
              container.listen(
                provider,
                listener.call,
                fireImmediately: true,
              );

              await container.read(provider.notifier).onLoadBalances();

              final MonthBalanceCalculationHelper calculator =
                  MonthBalanceCalculationHelper(
                monthExpenses: expenses,
                dailyBudget: currentMonthDailyBudgetModel.amount,
                monthDate: currentMonthDailyBudgetModel.periodStart,
              );

              final MonthBalancesValue balances = MonthBalancesValue(
                currentMonthDailyBudget: currentMonthDailyBudgetModel,
                currentWeekBalance: calculator.weekBalance,
                currentMonthBalance: calculator.monthBalance,
                currentDayBalance: calculator.todayBalance,
              );

              verifyInOrder([
                () => listener(
                      null,
                      AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.data(
                        GetCurrentMonthBalancesControllerStateData(
                          balances: balances,
                        ),
                      ),
                    ),
                () => listener(
                      AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.data(
                        GetCurrentMonthBalancesControllerStateData(
                          balances: balances,
                        ),
                      ),
                      any(
                        that: isA<
                            AsyncLoading<
                                GetCurrentMonthBalancesControllerStateData>>(),
                      ),
                    ),
                () => listener(
                      any(
                        that: isA<
                            AsyncLoading<
                                GetCurrentMonthBalancesControllerStateData>>(),
                      ),
                      AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.data(
                        GetCurrentMonthBalancesControllerStateData(
                          balances: balances,
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

      group(
        ".build()",
        () {
          test(
            "given [ExpensesRepository].getExpenses throws"
            "when [GetCurrentMonthBalancesController] is built"
            "then should emit states in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => expensesRepository.getExpenses(
                  filter: any(named: "filter"))).thenThrow(Exception("error"));

              // when
              container.listen(
                getCurrentMonthBalancesControllerProvider(
                    currentMonthDailyBudgetModel),
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              verifyInOrder([
                () => listener.call(
                      null,
                      const AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.loading(),
                    ),
                () => listener.call(
                      const AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.loading(),
                      any(
                        that: isA<
                                AsyncError<
                                    GetCurrentMonthBalancesControllerStateData>>()
                            .having((e) {
                          return e.error;
                        }, "error", isA<Exception>()).having(
                                (e) => e.stackTrace,
                                "stackTrace",
                                isA<StackTrace>()),
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
            "when [GetCurrentMonthBalancesController] is built"
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
                getCurrentMonthBalancesControllerProvider(
                    currentMonthDailyBudgetModel),
                listener.call,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              final MonthBalanceCalculationHelper calculator =
                  MonthBalanceCalculationHelper(
                monthExpenses: expenses,
                dailyBudget: currentMonthDailyBudgetModel.amount,
                monthDate: currentMonthDailyBudgetModel.periodStart,
              );

              final MonthBalancesValue balances = MonthBalancesValue(
                currentMonthDailyBudget: currentMonthDailyBudgetModel,
                currentWeekBalance: calculator.weekBalance,
                currentMonthBalance: calculator.monthBalance,
                currentDayBalance: calculator.todayBalance,
              );

              verifyInOrder([
                () => listener.call(
                      null,
                      const AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.loading(),
                    ),
                () => listener.call(
                      const AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.loading(),
                      AsyncValue<
                          GetCurrentMonthBalancesControllerStateData>.data(
                        GetCurrentMonthBalancesControllerStateData(
                            balances: balances),
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

class _FakeGetExpensesFilterValue extends Fake
    implements GetExpensesFilterValue {}

class _FakeGetCurrentMonthBalancesControllerStateData extends Fake
    implements GetCurrentMonthBalancesControllerStateData {}
