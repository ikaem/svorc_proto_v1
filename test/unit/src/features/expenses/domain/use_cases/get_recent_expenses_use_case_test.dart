import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_recent_expenses_use_case.dart';

void main() {
  final ExpensesRepository expensesRepository = _MockExpensesRepository();

// tested class
  final GetRecentExpensesUseCase useCase =
      GetRecentExpensesUseCase(expensesRepository: expensesRepository);

  setUpAll(() {
    registerFallbackValue(_FakeGetExpensesFilterValue());
  });

  tearDown(() {
    reset(expensesRepository);
  });

  group(
    GetRecentExpensesUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given nothing in particular"
            "when [call] is called "
            "then should call [ExpensesRepository.getExpenses] with correct arguments and return expected result",
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

              when(
                () => expensesRepository.getExpenses(
                    filter: any(named: "filter")),
              ).thenAnswer(
                (_) async => expensesModels,
              );

              // given

              // when
              final result = await useCase();

              // then
              expect(result, expensesModels);

              verify(
                () => expensesRepository.getExpenses(
                  filter: any(
                    named: "filter",
                    that: predicate<GetExpensesFilterValue>(
                      (filter) {
                        if (filter.limit != 5) {
                          return false;
                        }
                        if (filter.minDate != null) {
                          return false;
                        }
                        if (filter.maxDate != null) {
                          return false;
                        }

                        return true;
                      },
                    ),
                  ),
                ),
              ).called(1);

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
