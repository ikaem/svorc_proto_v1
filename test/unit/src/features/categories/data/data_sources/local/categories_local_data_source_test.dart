import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source_impl.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
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
