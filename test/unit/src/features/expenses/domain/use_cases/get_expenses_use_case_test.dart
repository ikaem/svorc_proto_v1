import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_expenses_use_case.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/get_expenses_filter_value.dart';

void main() {
  final ExpensesRepository expensesRepository = _MockExpensesRepository();

  // tested class
  final GetExpensesUseCase useCase =
      GetExpensesUseCase(expensesRepository: expensesRepository);

  setUpAll(() {
    registerFallbackValue(const GetExpensesFilterValue());
  });

  tearDown(() {
    reset(expensesRepository);
  });

  group(
    GetExpensesUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given [GetExpensesFilterValue]"
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
                    filter: any(
                  named: "filter",
                )),
              ).thenAnswer(
                (_) async => expensesModels,
              );

              // given
              final GetExpensesFilterValue filter = GetExpensesFilterValue(
                limit: 5,
                offset: 0,
                minDate: DateTime.now().subtract(const Duration(days: 30)),
                maxDate: DateTime.now(),
              );

              // when
              final result = await useCase(filter);

              // then
              expect(result, equals(expensesModels));

              verify(
                () => expensesRepository.getExpenses(
                  filter: filter,
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


// GetExpensesFilterValue