import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source_impl.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/new_category_local_value.dart';
import 'package:svorc_proto_v1/src/features/categories/utils/converters/category_converters.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

import '../../../../../../../utils/database/test_database_wrapper.dart';

void main() {
  late TestDatabaseWrapper testDatabaseWrapper;
  late CategoriesLocalDataSource dataSource;

  setUp(() {
    testDatabaseWrapper =
        TestDatabaseWrapper.getInitializedTestDatabaseWrapper();

    dataSource = CategoriesLocalDataSourceImpl(
      databaseWrapper: testDatabaseWrapper.databaseWrapper,
    );
  });

  tearDown(() {
    testDatabaseWrapper.databaseWrapper.close();
  });

  group(
    $CategoryLocalEntityTable,
    () {
      group(
        "createCategory",
        () {
          test(
            "given [NewCategoryLocalValue] is provided"
            "when [createCategory] is called"
            "then should add new [CategoryLocalEntity] to the database and return expected id",
            () async {
              // setup
              const name = "category_2";

              // given
              const newValue = NewCategoryLocalValue(name: name);

              // when
              final id = await dataSource.createCategory(newCategory: newValue);

              // then
              final select = testDatabaseWrapper
                  .databaseWrapper.database.categoryLocalEntity
                  .select();
              final categorySelect = select..where((tbl) => tbl.id.equals(id));

              final entityData = await categorySelect.getSingle();
              final entityValue =
                  CategoryConverters.toEntityValueFromEntityData(
                      entityData: entityData);

              final expectedEntityValue =
                  CategoryLocalEntityValue(id: id, name: name);

              expect(
                entityValue,
                equals(expectedEntityValue),
              );
              expect(id, equals(2));

              // cleanup
            },
          );

          test(
            "given existing [CategoryLocalEntity] is stored in the database"
            "when [createCategory] is called with the same name as the existing [CategoryLocalEntity]"
            "then should throw expected exception",
            () async {
              // setup
              const name = "category_2";

              const value = NewCategoryLocalValue(name: name);
              final companion = CategoryLocalEntityCompanion.insert(
                name: name,
              );

              // given
              await testDatabaseWrapper
                  .databaseWrapper.database.categoryLocalEntity
                  .insertOne(companion);

              // when / then
              expect(
                () => dataSource.createCategory(newCategory: value),
                throwsA(predicate<SqliteException>((exception) {
                  return exception.message ==
                      'UNIQUE constraint failed: category_local_entity.name';
                })),
              );

              // cleanup
            },
          );
        },
      );

      group(
        "getCategoryById",
        () {
          test(
            "given [CategoryLocalEntity] is stored in the database"
            "when [getCategoryById] is called with the id of the stored [CategoryLocalEntity]"
            "then should return the expected [CategoryLocalEntityValue]",
            () async {
              // setup
              final categoryCompanion = CategoryLocalEntityCompanion.insert(
                id: const Value(2),
                name: "category_2",
              );

              // given
              await testDatabaseWrapper
                  .databaseWrapper.database.categoryLocalEntity
                  .insertOne(categoryCompanion);

              // when
              final category = await dataSource.getCategoryById(id: 2);

              // then
              final expectedCategoryValue = CategoryLocalEntityValue(
                id: categoryCompanion.id.value,
                name: categoryCompanion.name.value,
              );

              expect(
                category,
                equals(expectedCategoryValue),
              );

              // cleanup
            },
          );
        },
      );

      group(
        "getCategories",
        () {
// on initial app start, there should be at least general categories

          test(
            "given [DriftAppDatabase] is initialized"
            "when [getCategories] is called"
            "then should always include 'general' [CategoryLocalEntityValue] in the response",
            () async {
              // setup

              // given

              // when
              final categories = await dataSource.getCategories();

              // then

              expect(
                categories,
                contains(_generalCategoryEntityValue),
              );

              // cleanup
            },
          );

          test(
            "given multiple [CategoryLocalEntityValue] are stored in the database"
            "when [getCategories] is called"
            "then should return expected [CategoryLocalEntityValue]s",
            () async {
              // setup
              final categoryCompanions = List.generate(
                3,
                (index) => CategoryLocalEntityCompanion.insert(
                  id: Value(index + 2),
                  name: "category_${index + 2}",
                ),
              );

              // given
              await testDatabaseWrapper
                  .databaseWrapper.database.categoryLocalEntity
                  .insertAll(categoryCompanions);

              // when
              final categories = await dataSource.getCategories();

              // then
              final expectedCategoryValues = [
                _generalCategoryEntityValue,
                ...categoryCompanions.map(
                  (companion) => CategoryLocalEntityValue(
                    id: companion.id.value,
                    name: companion.name.value,
                  ),
                ),
              ];

              expect(
                categories,
                equals(expectedCategoryValues),
              );

              // cleanup
            },
          );
        },
      );
    },
  );
}

const _generalCategoryEntityValue = CategoryLocalEntityValue(
  id: 1,
  name: "general",
);
