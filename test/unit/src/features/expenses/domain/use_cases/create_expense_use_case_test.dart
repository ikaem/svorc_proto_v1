import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/create_expense_use_case.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';

void main() {
  final ExpensesRepository expensesRepository = _MockExpensesRepository();

  // tested class
  final CreateExpenseUseCase useCase =
      CreateExpenseUseCase(expensesRepository: expensesRepository);

  setUpAll(() {
    registerFallbackValue(_FakeSome());
  });

  tearDown(() {
    reset(expensesRepository);
  });

  group(
    CreateExpenseUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given [int] amount, [DateTime] date, [String?] note, [int] categoryId"
            "when [call] is called "
            "then should call [ExpensesRepository.createExpense] with correct arguments and return expected result",
            () async {
              // setup
              const int expectedResult = 1;

              when(
                () => expensesRepository.createExpense(
                  newExpense: any(named: "newExpense"),
                ),
              ).thenAnswer(
                (_) async => expectedResult,
              );

              // given
              const int amount = 1000;
              final DateTime date = DateTime.now();
              const String note = "Some note";
              const int categoryId = 1;

              // when
              final result = await useCase(
                amount: amount,
                date: date,
                note: note,
                categoryId: categoryId,
              );

              // then
              expect(result, equals(expectedResult));

              verify(() => expensesRepository.createExpense(
                    newExpense: NewExpenseLocalValue(
                        amount: amount,
                        date: date,
                        note: note,
                        categoryId: categoryId),
                  ));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockExpensesRepository extends Mock implements ExpensesRepository {}

class _FakeSome extends Fake implements NewExpenseLocalValue {}
