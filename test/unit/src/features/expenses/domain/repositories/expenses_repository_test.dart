import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository_impl.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/expense_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';

void main() {
  final expensesLocalDataSource = _MockExpensesLocalDataSource();

  // tested class
  final repository = ExpensesRepositoryImpl(
    expensesLocalDataSource: expensesLocalDataSource,
  );

  setUpAll(
    () {
      registerFallbackValue(_FakeNewExpenseLocalValue());
      registerFallbackValue(const GetExpensesFilterValue());
    },
  );

  tearDown(
    () {
      reset(expensesLocalDataSource);
    },
  );

  group(
    "$ExpensesRepository",
    () {
      group(
        "createExpense",
        () {
          test(
            "given [NewExpenseLocalValue] "
            "when [createExpense] is called "
            "then should call [ExpensesLocalDataSource.createExpense] with expected arguments and return expected id",
            () async {
              // setup
              when(
                () => expensesLocalDataSource.createExpense(
                  newExpense: any(named: "newExpense"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              final localValue = NewExpenseLocalValue(
                amount: 1,
                date: DateTime.now(),
                categoryId: 1,
                note: "note",
              );

              // when
              final id = await repository.createExpense(
                newExpense: localValue,
              );

              // then
              verify(
                () => expensesLocalDataSource.createExpense(
                  newExpense: localValue,
                ),
              ).called(1);
              expect(id, equals(1));

              // cleanup
            },
          );
        },
      );

      group(
        "updateExpense",
        () {
          test(
            "given [amount], [date], [categoryId], [note] and [id] "
            "when [updateExpense] is called "
            "then should call [ExpensesLocalDataSource.updateExpense] with expected arguments and return expected id",
            () async {
              // setup
              when(
                () => expensesLocalDataSource.updateExpense(
                  id: any(named: "id"),
                  amount: any(named: "amount"),
                  date: any(named: "date"),
                  categoryId: any(named: "categoryId"),
                  note: any(named: "note"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const id = 1;
              const amount = 1;
              final date = DateTime.now();
              const categoryId = 1;
              const note = "note";

              // when
              final updatedId = await repository.updateExpense(
                id: id,
                amount: amount,
                date: date,
                categoryId: categoryId,
                note: note,
              );

              // then
              verify(() => expensesLocalDataSource.updateExpense(
                    id: id,
                    amount: amount,
                    date: date,
                    categoryId: categoryId,
                    note: note,
                  )).called(1);
              expect(updatedId, equals(1));

              // cleanup
            },
          );
        },
      );

      group(
        "getExpenses",
        () {
          // TODO tests for filters will be needed here
          test(
            "given no filter arguments "
            "when [getExpenses] is called "
            "then should call [ExpensesLocalDataSource.getExpenses] with expected arguments and return expected [List<ExpenseModel>]",
            () async {
              // setup
              final expenseEntityValues = List.generate(
                3,
                (index) => ExpenseLocalEntityValue(
                  id: index,
                  amount: index,
                  date: DateTime.now(),
                  category: const CategoryLocalEntityValue(
                    id: 1,
                    name: "general",
                  ),
                  note: "note$index",
                ),
              );

              when(
                () => expensesLocalDataSource.getExpenses(
                  filter: any(named: "filter"),
                ),
              ).thenAnswer(
                (_) async => expenseEntityValues,
              );

              // given

              // when
              final expenses = await repository.getExpenses(
                filter: const GetExpensesFilterValue(),
              );

              // then
              final expectedExpenseModels = expenseEntityValues
                  .map(
                    (e) => ExpenseModel(
                      id: e.id,
                      amount: e.amount,
                      date: e.date,
                      category: CategoryModel(
                        id: e.category.id,
                        name: e.category.name,
                      ),
                      note: e.note,
                    ),
                  )
                  .toList();

              verify(
                () => expensesLocalDataSource.getExpenses(
                  filter: const GetExpensesFilterValue(),
                ),
              ).called(1);
              expect(expenses, equals(expectedExpenseModels));

              // cleanup
            },
          );
        },
      );

      group(
        "getExpenseById",
        () {
          test(
            "given [id] "
            "when [getExpenseById] is called "
            "then should call [ExpensesLocalDataSource.getExpenseById] with expected arguments and return expected [ExpenseModel]",
            () async {
              // setup
              final entityValue = ExpenseLocalEntityValue(
                id: 1,
                amount: 1,
                date: DateTime.now(),
                category: const CategoryLocalEntityValue(
                  id: 1,
                  name: "general",
                ),
                note: "note",
              );

              when(
                () => expensesLocalDataSource.getExpenseById(
                  id: any(named: "id"),
                ),
              ).thenAnswer(
                (_) async => entityValue,
              );

              // given
              const id = 1;

              // when
              final model = await repository.getExpenseById(
                id: id,
              );

              // then
              final expectedModel = ExpenseModel(
                id: entityValue.id,
                amount: entityValue.amount,
                date: entityValue.date,
                category: CategoryModel(
                  id: entityValue.category.id,
                  name: entityValue.category.name,
                ),
                note: entityValue.note,
              );

              verify(
                () => expensesLocalDataSource.getExpenseById(
                  id: id,
                ),
              ).called(1);
              expect(model, equals(expectedModel));

              // cleanup
            },
          );
        },
      );

      group(
        "deleteExpense",
        () {
          test(
            "given [id] "
            "when [deleteExpense] is called "
            "then should call [ExpensesLocalDataSource.deleteExpense] with expected arguments and return expected id",
            () async {
              // setup
              when(
                () => expensesLocalDataSource.deleteExpense(
                  id: any(named: "id"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const id = 1;

              // when
              final deletedId = await repository.deleteExpense(
                id: id,
              );

              // then
              verify(
                () => expensesLocalDataSource.deleteExpense(
                  id: id,
                ),
              ).called(1);

              expect(deletedId, equals(1));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockExpensesLocalDataSource extends Mock
    implements ExpensesLocalDataSource {}

class _FakeNewExpenseLocalValue extends Fake implements NewExpenseLocalValue {}
