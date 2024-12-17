import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/watch_recent_expenses_use_case.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/get_expenses_filter_value.dart';

void main() {
  final ExpensesRepository expensesRepository = _MockExpensesRepository();

// tested class
  final WatchRecentExpensesUseCase useCase =
      WatchRecentExpensesUseCase(expensesRepository: expensesRepository);

  setUpAll(() {
    registerFallbackValue(_FakeGetExpensesFilterValue());
  });

  tearDown(() {
    reset(expensesRepository);
  });

  group(
    WatchRecentExpensesUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given nothing in particular"
            "when [call] is called "
            "then should call [ExpensesRepository.watchExpenses] with correct arguments and return expected result",
            () async {
              // setup
              final List<ExpenseModel> expensesModels = List.generate(
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

              final Stream<List<ExpenseModel>> stream =
                  Stream.value(expensesModels);

              when(
                () => expensesRepository.watchExpenses(
                    filter: any(named: "filter")),
              ).thenAnswer(
                (_) => stream,
              );

              // given

              // when
              final Stream<List<ExpenseModel>> result = useCase();

              // then

              verify(
                () => expensesRepository.watchExpenses(
                  filter: const GetExpensesFilterValue(
                    limit: 5,
                  ),
                ),
              ).called(1);
              expect(result, emits(expensesModels));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockExpensesRepository extends Mock implements ExpensesRepository {}

class _FakeGetExpensesFilterValue extends Fake
    implements GetExpensesFilterValue {}
