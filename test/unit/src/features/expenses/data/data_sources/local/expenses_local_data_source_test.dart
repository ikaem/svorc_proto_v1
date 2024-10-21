import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source_impl.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/expense_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/utils/converters/expenses_converters.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/extensions/date_time_extensions.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

import '../../../../../../../utils/database/test_database_wrapper.dart';

void main() {
  late TestDatabaseWrapper testDatabaseWrapper;

  // tested class
  late ExpensesLocalDataSource expensesLocalDataSource;

  setUp(() {
    testDatabaseWrapper =
        TestDatabaseWrapper.getInitializedTestDatabaseWrapper();

    expensesLocalDataSource = ExpensesLocalDataSourceImpl(
      databaseWrapper: testDatabaseWrapper.databaseWrapper,
    );
  });

  tearDown(() {
    testDatabaseWrapper.databaseWrapper.close();
  });

  group(
    "$ExpensesLocalDataSource",
    () {
      group(
        "createExpense",
        () {
          test(
            "given [NewExpenseLocalValue]"
            "when [.createExpense] is called"
            "then should add new expense to database and return expected id",
            () async {
              // setup
              const amount = 100;
              final date = DateTime.now();
              // TODO just test if this is going to throw an error because category with id 2 does not exist
              // TODO come back to this - this does not seem to throw in test database when category does not exist
              const categoryId = 1;
              const note = "note";

              // given
              final value = NewExpenseLocalValue(
                amount: amount,
                date: date,
                categoryId: categoryId,
                note: note,
              );

              // when
              final id = await expensesLocalDataSource.createExpense(
                newExpense: value,
              );

              // then
              final select =
                  testDatabaseWrapper.databaseWrapper.expenseRepo.select();
              final expenseSelect = select..where((tbl) => tbl.id.equals(1));

              final entityData = await expenseSelect.getSingle();
              // final entityValue =
              //     ExpensesConverters.toEntityValueFromEntityData(
              //   expenseEntityData: entityData,

              // );
              // final expectedEntityData = ExpenseLocalEntityData(
              //   id: 1,
              //   amount: amount,
              //   date: date.normalizedToSeconds,
              //   categoryId: categoryId,
              // );

              // final expectedEntityValue = ExpenseLocalEntityValue(
              //   id: 1,
              //   amount: amount,
              //   date: date.normalizedToSeconds,
              //   category: const CategoryLocalEntityValue(
              //     id: 1,
              //     name: "general",
              //   ),
              //   note: note,
              // );

              // expect(entityValue, equals(expectedEntityValue));
              expect(entityData.amount, equals(amount));
              expect(entityData.date, equals(date.normalizedToSeconds));
              expect(entityData.categoryId, equals(categoryId));
              expect(entityData.note, equals(note));
              expect(id, equals(1));

              // cleanup
            },
          );

          // when note is not pased - no note will be on returned data - TODO make test for this
        },
      );

      group(
        "updateExpense",
        () {
          test(
            "given existing [ExpenseLocalEntity]"
            "when [.updateExpense] is called with new values"
            "then should update existing [ExpenseLocalEntity] in database and return expected id",
            () async {
              // setup
              final originalCompanion = ExpenseLocalEntityCompanion.insert(
                date: DateTime.now(),
                amount: 100,
                categoryId: 2,
                note: const Value("note"),
              );

              // given
              final id = await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertOne(originalCompanion);

              // when
              final updatedDate = DateTime.now().add(const Duration(days: 1));
              const updatedAmount = 200;
              const updatedCategoryId = 3;
              const updatedNote = "";

              // final updatedValue = ExpenseLocalEntityValue(
              //   id: id,
              //   amount: updatedAmount,
              //   date: updatedDate,
              //   categoryId: updatedCategoryId,
              //   note: updatedNote,
              // );
// TODO this is to test that updatedAt fields work propery. it does not. need to set it up automatically to be updated on each write
              await Future.delayed(const Duration(seconds: 3));

              final updatedId = await expensesLocalDataSource.updateExpense(
                id: id,
                amount: updatedAmount,
                date: updatedDate,
                categoryId: updatedCategoryId,
                note: updatedNote,
              );

              // then
              final select =
                  testDatabaseWrapper.databaseWrapper.expenseRepo.select();
              final expenseSelect = select..where((tbl) => tbl.id.equals(id));

              final entityData = await expenseSelect.getSingle();
              // final entityValue =
              //     ExpensesConverters.toEntityValueFromEntityData(
              //   expenseEntityData: entityData,
              // );

              // final expectedEntityValue = ExpenseLocalEntityValue(
              //   id: id,
              //   amount: updatedAmount,
              //   date: updatedDate.normalizedToSeconds,
              //   category: const CategoryLocalEntityValue(
              //     id: 1,
              //     name: "general",
              //   ),
              //   note: updatedNote,
              // );

              // expect(entityValue, equals(expectedEntityValue));
              expect(entityData.amount, equals(updatedAmount));
              expect(entityData.date, equals(updatedDate.normalizedToSeconds));
              expect(entityData.categoryId, equals(updatedCategoryId));
              expect(entityData.note, equals(updatedNote));
              expect(updatedId, equals(id));

              // cleanup
            },
          );

          // TODO test that when passing null values, those fields will not be updated - this only makes sense for note, but lets pass null for all
        },
      );

      group(
        "getExpenseById",
        () {
          test(
            "given matching [ExpenseLocalEntity] exists in database"
            "when [.getExpenseById] is called"
            "then should return expected [ExpenseLocalEntityValue]",
            () async {
              // setup
              final companion = ExpenseLocalEntityCompanion.insert(
                date: DateTime.now(),
                amount: 100,
                categoryId: 1,
                note: const Value("note"),
              );

              // given
              final id = await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertOne(companion);

              // when
              final entityValue = await expensesLocalDataSource.getExpenseById(
                id: id,
              );

              // then
              final expectedEntityValue = ExpenseLocalEntityValue(
                id: id,
                amount: 100,
                date: companion.date.value.normalizedToSeconds,
                // categoryId: 2,
                category: const CategoryLocalEntityValue(
                  id: 1,
                  name: "general",
                ),
                note: "note",
              );

              expect(entityValue, equals(expectedEntityValue));

              // cleanup
            },
          );

          test(
            "given no matching [ExpenseLocalEntity] exists in database"
            "when [.getExpenseById] is called"
            "then should return null",
            () async {
              // setup

              // given

              // when
              final entityValue = await expensesLocalDataSource.getExpenseById(
                id: 1,
              );

              // then
              expect(entityValue, isNull);

              // cleanup
            },
          );
        },
      );

      group(
        "getExpenses",
        () {
          // TODO this needs to be tested

          test(
            "given [ExpenseLocalEntity]s exists in database"
            "when [.getExpenses] is called"
            "then should return expected [List<ExpenseLocalEntityValue>]",
            () async {
              // setup
              final companions = List.generate(3, (index) {
                return ExpenseLocalEntityCompanion.insert(
                  id: Value(index + 1),
                  date: DateTime.now().add(Duration(seconds: index)),
                  amount: (index + 1) * 100,
                  categoryId: 1,
                  note: Value("note ${index + 1}"),
                );
              });

              // given
              await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertAll(companions);

              // when
              final entityValues = await expensesLocalDataSource.getExpenses(
                filter: const GetExpensesFilterValue(),
              );

              // then
              final expectedEntityValues = companions
                  .map(
                    (e) => ExpenseLocalEntityValue(
                      id: e.id.value,
                      amount: e.amount.value,
                      date: e.date.value.normalizedToSeconds,
                      category: const CategoryLocalEntityValue(
                        id: 1,
                        name: "general",
                      ),
                      note: e.note.value,
                    ),
                  )
                  .toList()
                  // TODO because we order by desc date
                  .reversed
                  .toList();

              expect(entityValues, equals(expectedEntityValues));

              // cleanup
            },
          );

          test(
            "given multiple [ExpenseLocalEntity]s exists in database"
            "when [.getExpenses] is called with [limit] filter"
            "then should return expected [List<ExpenseLocalEntityValue>]",
            () async {
              // setup
              final companions = List.generate(7, (index) {
                return ExpenseLocalEntityCompanion.insert(
                  id: Value(index + 1),
                  date: DateTime.now(),
                  amount: (index + 1) * 100,
                  categoryId: 1,
                  note: Value("note ${index + 1}"),
                );
              });

              // given
              await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertAll(companions);

              // when
              const filterLimit = 5;
              const filter = GetExpensesFilterValue(
                limit: filterLimit,
              );

              final entityValues = await expensesLocalDataSource.getExpenses(
                filter: filter,
              );

              // then
              final expectedEntityValues =
                  companions.sublist(0, filterLimit).map(
                        (e) => ExpenseLocalEntityValue(
                          id: e.id.value,
                          amount: e.amount.value,
                          date: e.date.value.normalizedToSeconds,
                          category: const CategoryLocalEntityValue(
                            id: 1,
                            name: "general",
                          ),
                          note: e.note.value,
                        ),
                      );

              expect(entityValues, equals(expectedEntityValues));

              // cleanup
            },
          );

          test(
            "given matching [ExpenseLocalEntity]s exists in database"
            "when [.getExpenses] is called with [maxDate] filter"
            "then should return expected [List<ExpenseLocalEntityValue>]",
            () async {
              // setup
              final dateNow = DateTime.now();
              final companion = ExpenseLocalEntityCompanion.insert(
                id: const Value(1),
                date: dateNow,
                amount: 100,
                categoryId: 1,
                note: const Value("note"),
              );

              // given
              await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertOne(companion);

              // when
              final filterMaxDate = dateNow.add(const Duration(days: 1));
              final filter = GetExpensesFilterValue(
                maxDate: filterMaxDate,
              );

              final entityValues = await expensesLocalDataSource.getExpenses(
                filter: filter,
              );

              // then
              final expectedEntityValues = [
                ExpenseLocalEntityValue(
                  id: companion.id.value,
                  amount: companion.amount.value,
                  date: companion.date.value.normalizedToSeconds,
                  category: const CategoryLocalEntityValue(
                    id: 1,
                    name: "general",
                  ),
                  note: companion.note.value,
                ),
              ];

              expect(entityValues, equals(expectedEntityValues));

              // cleanup
            },
          );

          test(
            "given no matching [ExpenseLocalEntity]s exists in database"
            "when [.getExpenses] is called with [maxDate] filter"
            "then should return empty list",
            () async {
              // setup
              final dateNow = DateTime.now();
              final companion = ExpenseLocalEntityCompanion.insert(
                id: const Value(1),
                date: dateNow,
                amount: 100,
                categoryId: 1,
                note: const Value("note"),
              );

              // given
              await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertOne(companion);

              // when
              final filterMaxDate = dateNow.subtract(const Duration(days: 1));
              final filter = GetExpensesFilterValue(
                maxDate: filterMaxDate,
              );

              final entityValues = await expensesLocalDataSource.getExpenses(
                filter: filter,
              );

              // then
              expect(entityValues, isEmpty);

              // cleanup
            },
          );

          test(
            "given matching [ExpenseLocalEntity]s exists in database"
            "when [.getExpenses] is called with [minDate] filter"
            "then should return expected [List<ExpenseLocalEntityValue>]",
            () async {
              // setup
              final dateNow = DateTime.now();
              final companion = ExpenseLocalEntityCompanion.insert(
                id: const Value(1),
                date: dateNow,
                amount: 100,
                categoryId: 1,
                note: const Value("note"),
              );

              // given
              await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertOne(companion);

              // when
              final filterMinDate = dateNow.subtract(const Duration(days: 1));
              final filter = GetExpensesFilterValue(
                minDate: filterMinDate,
              );

              final entityValues = await expensesLocalDataSource.getExpenses(
                filter: filter,
              );

              // then
              final expectedEntityValues = [
                ExpenseLocalEntityValue(
                  id: companion.id.value,
                  amount: companion.amount.value,
                  date: companion.date.value.normalizedToSeconds,
                  category: const CategoryLocalEntityValue(
                    id: 1,
                    name: "general",
                  ),
                  note: companion.note.value,
                ),
              ];

              expect(entityValues, equals(expectedEntityValues));

              // cleanup
            },
          );

          test(
            "given no matching [ExpenseLocalEntity]s exists in database"
            "when [.getExpenses] is called with [minDate] filter"
            "then should return empty list",
            () async {
              // setup
              final dateNow = DateTime.now();
              final companion = ExpenseLocalEntityCompanion.insert(
                id: const Value(1),
                date: dateNow,
                amount: 100,
                categoryId: 1,
                note: const Value("note"),
              );

              // given
              await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertOne(companion);

              // when
              final filterMinDate = dateNow.add(const Duration(days: 1));
              final filter = GetExpensesFilterValue(
                minDate: filterMinDate,
              );

              final entityValues = await expensesLocalDataSource.getExpenses(
                filter: filter,
              );

              // then

              expect(entityValues, isEmpty);

              // cleanup
            },
          );
        },
      );

      group(
        "deleteExpense",
        () {
          test(
            "given an existing [ExpenseLocalEntity] in database"
            "when [.deleteExpense] is called"
            "then should delete the [ExpenseLocalEntity] and return expected id",
            () async {
              // setup
              final companion = ExpenseLocalEntityCompanion.insert(
                date: DateTime.now(),
                amount: 100,
                categoryId: 1,
                note: const Value("note"),
              );

              // given
              final id = await testDatabaseWrapper.databaseWrapper.expenseRepo
                  .insertOne(companion);

              // when
              final deletedId =
                  await expensesLocalDataSource.deleteExpense(id: id);

              // then
              final select =
                  testDatabaseWrapper.databaseWrapper.expenseRepo.select();
              final expenseSelect = select..where((tbl) => tbl.id.equals(id));

              final entityData = await expenseSelect.getSingleOrNull();

              expect(entityData, isNull);
              expect(deletedId, equals(id));

              // cleanup
            },
          );
        },
      );
    },
  );
}
