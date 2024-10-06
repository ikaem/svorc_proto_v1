import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/features/expenses/data/data_sources/local/expenses_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/expense_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/new_expense_local_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/utils/converters/expenses_converters.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_database_wrapper.dart';

class ExpensesLocalDataSourceImpl implements ExpensesLocalDataSource {
  const ExpensesLocalDataSourceImpl({
    required DriftDatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;

  final DriftDatabaseWrapper _databaseWrapper;

  @override
  Future<int> createExpense({
    required NewExpenseLocalValue newExpense,
  }) async {
    final companion = ExpenseLocalEntityCompanion.insert(
      date: newExpense.date,
      amount: newExpense.amount,
      categoryId: newExpense.categoryId,
      note: Value(newExpense.note),
    );

    final id = await _databaseWrapper.database.expenseLocalEntity.insertOne(
      companion,
    );

    return id;
  }

  @override
  Future<int> deleteExpense({required int id}) async {
    final delete = _databaseWrapper.database.expenseLocalEntity.delete();
    final deleteExpense = delete..where((tbl) => tbl.id.equals(id));

    final deletedId = await deleteExpense.go();

    return deletedId;
/* 


// TODO test only

    final delete =
        _databaseWrapper.database.periodDailyBudgetLocalEntity.delete();
    final deleteBudget = delete..where((tbl) => tbl.id.equals(1));

    final result = await deleteBudget.go();



 */

    // throw UnimplementedError();
  }

  @override
  Future<ExpenseLocalEntityValue?> getExpenseById({required int id}) async {
    final select = _databaseWrapper.expenseRepo.select();
    final joinedSelect = select.join([
      leftOuterJoin(
        _databaseWrapper.categoryRepo,
        _databaseWrapper.categoryRepo.id.equalsExp(
          _databaseWrapper.expenseRepo.categoryId,
        ),
      )
    ]);

    final findExpenseSelect = joinedSelect
      ..where(_databaseWrapper.expenseRepo.id.equals(id));

    final result = await findExpenseSelect.get();

    if (result.isEmpty) return null;

    final expenseData = result.first.readTable(_databaseWrapper.expenseRepo);
    final categoryData = result.first.readTable(_databaseWrapper.categoryRepo);

    final entityValue = ExpensesConverters.toEntityValueFromEntityData(
      expenseEntityData: expenseData,
      categoryEntityData: categoryData,
    );

    return entityValue;

/*     

// TODO this works for getting single entity, but we no joined category
    final select = _databaseWrapper.database.expenseLocalEntity.select();
    final expenseSelect = select..where((tbl) => tbl.id.equals(id));

    final entityData = await expenseSelect.getSingleOrNull();
    if (entityData == null) {
      return null;
    }

    final entityValue =
        ExpensesConverters.toEntityValueFromEntityData(entityData: entityData);
    return entityValue; */
  }

  @override
  Future<List<ExpenseLocalEntityValue>> getExpenses({
    required GetExpensesFilterValue filter,
  }) async {
    final select = _databaseWrapper.expenseRepo.select();
    // TODO original
    // final joinedSelect = select.join([
    JoinedSelectStatement<HasResultSet, dynamic> joinedSelect = select.join([
      leftOuterJoin(
        _databaseWrapper.categoryRepo,
        _databaseWrapper.categoryRepo.id.equalsExp(
          _databaseWrapper.expenseRepo.categoryId,
        ),
      )
    ]);

    // final result = await joinedSelect.get();

    final minDate = filter.minDate;
    final maxDate = filter.maxDate;
    final limit = filter.limit;

    if (minDate != null) {
      // TODO this is what copilot suggested -------------
      // final fromDateExpression = _databaseWrapper.expenseRepo.date.isSmallerOrEqualValue(fromDate);
      // joinedSelect.where(fromDateExpression);
      // -----------

      // need to create an expression
// its here - https://drift.simonbinder.eu/docs/dart-api/select/#joins
      final fromDateExpression =
          _databaseWrapper.expenseRepo.date.isBiggerOrEqualValue(minDate);

      // to where on joined select, we have to pass expression directly
      // joinedSelect = joinedSelect..where(fromDateExpression);
      joinedSelect.where(fromDateExpression);
      // joinedSelect = joinedSelect..where(() {
      //   // return tbl.date.isBiggerOrEqualValue(fromDate);

      //   tbl.

      // });
    }

    if (maxDate != null) {
      final toDateExpression =
          _databaseWrapper.expenseRepo.date.isSmallerOrEqualValue(maxDate);

      joinedSelect.where(toDateExpression);
    }
    if (limit != null) {
      joinedSelect.limit(limit);
    }

    final entityValues = await joinedSelect.map((row) {
      final expenseData = row.readTable(_databaseWrapper.expenseRepo);
      final categoryData = row.readTable(_databaseWrapper.categoryRepo);

      final entityValue = ExpensesConverters.toEntityValueFromEntityData(
        expenseEntityData: expenseData,
        categoryEntityData: categoryData,
      );

      return entityValue;
    }).get();

    return entityValues;
  }

  @override
  Future<int> updateExpense({
    required int id,
    int? amount,
    DateTime? date,
    int? categoryId,
    String? note,
  }) async {
    // TODO if any of the values is null, it seems this approach will not work. so we can instead pass enpty string if instead of null if we want to remove all text from note
    // TODO only test this
    const emptyCompanion = ExpenseLocalEntityCompanion(
        // date: Value(null),
        // categoryId: null,
        // note: null,
        );

    // companion.copyWith();
    final updatedCompanion = emptyCompanion.copyWith(
      amount: amount == null ? null : Value(amount),
      date: date == null ? null : Value(date),
      categoryId: categoryId == null ? null : Value(categoryId),
      note: note == null ? null : Value(note),
    );

    final update = _databaseWrapper.database.expenseLocalEntity.update();
    final updateExpense = update..where((tbl) => tbl.id.equals(id));

    final updatedId = await updateExpense.write(updatedCompanion);
    return updatedId;
  }
// create expense

// update expense - allow to update amount, date, category, note

// get expenses - for now without filtering

// get expense by id

// delete expense
}


/* 

    if (matchTitle != null) {
      // TODO I hope this will handle sanitization
      final matchTitleVariable = Variable.withString(matchTitle);
      // TODO this is a bit silly - currently, "asd" for match title will return one match, even if there are only matches with these titles in db
      /* 
ivanović
ivan
ivka
ivo
ivor
ovan
      
       */
      final isSimilarTitleExpression = CustomExpression<bool>(
        // TODO maybe levenhstein is not that good for this - maybe there is better
        "LEVENSHTEIN(title, '${matchTitleVariable.value}') <= 3",
        precedence: Precedence.primary,
      );

      findMatches = findMatches
        ..where((tbl) {
          return isSimilarTitleExpression;
        });
    }






 */