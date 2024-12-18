import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/get_expenses/get_expenses_controller.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/get_expenses_filter_value.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockExpensesRepository expensesRepository = _MockExpensesRepository();

  final _MockListener<AsyncValue<GetExpensesControllerStateData?>> listener =
      _MockListener<AsyncValue<GetExpensesControllerStateData?>>();

  setUpAll(() {
    registerFallbackValue(
        AsyncValue.data(_FakeGetExpensesControllerStateData()));
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
    GetExpensesController,
    () {
      group(
        "build()",
        () {
          // TODO add tests here
        },
      );

      group(
        "onGetExpenses()",
        () {
          // TODO only testing for now
          test(
            "given <pre-condition to the test>"
            "when <behavior we are specifying>"
            "then should <state we expect to happen>",
            () async {
              // setup
              final List<ExpenseModel> expenses = List.generate(
                30,
                (i) => ExpenseModel(
                  id: i + 1,
                  date: DateTime.now().add(Duration(seconds: i)),
                  amount: 100,
                  category: const CategoryModel(id: 1, name: "name"),
                ),
              ).reversed.toList();

              final ProviderContainer container = ProviderContainer();

              when(() => expensesRepository.getExpenses(
                      filter: any(named: "filter")))
                  .thenAnswer((_) async => expenses.sublist(0, 20));

              container.listen(
                getExpensesControllerProvider,
                listener.call,
                fireImmediately: true,
              );

              await container
                  .read(getExpensesControllerProvider.notifier)
                  .onGetExpenses(minDate: null, maxDate: null);

              when(() => expensesRepository.getExpenses(
                      filter: any(named: "filter")))
                  .thenAnswer((_) async => expenses.sublist(20));

              await Future.delayed(const Duration(milliseconds: 100));

              await container
                  .read(getExpensesControllerProvider.notifier)
                  .onGetExpenses(minDate: null, maxDate: null);

              print("listener");

              // -----------------------

              // given

              // when

              // then

              // cleanup
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

class _FakeGetExpensesControllerStateData extends Fake
    implements GetExpensesControllerStateData {}

class _FakeGetExpensesFilterValue extends Fake
    implements GetExpensesFilterValue {}
