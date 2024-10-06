import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository_impl.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/new_category_local_value.dart';

void main() {
  final categoryLocalDataSource = _MockCategoriesLocalDataSource();

  // tested class
  final repository = CategoriesRepositoryImpl(
    categoryLocalDataSource: categoryLocalDataSource,
  );

  setUpAll(
    () {
      registerFallbackValue(_FakeNewCategoryLocalValue());
    },
  );

  tearDown(
    () {
      reset(categoryLocalDataSource);
    },
  );

  group(
    "$CategoriesRepository",
    () {
      group(
        "createCategory",
        () {
          test(
            "given [NewCategoryLocalValue] "
            "when [createCategory] is called "
            "then should call [CategoriesLocalDataSource.createCategory] with expected arguments and return expected id",
            () async {
              // setup
              when(
                () => categoryLocalDataSource.createCategory(
                  newCategory: any(named: "newCategory"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const localValue = NewCategoryLocalValue(
                name: "name",
              );

              // when
              final id = await repository.createCategory(
                newCategory: localValue,
              );

              // then
              verify(
                () => categoryLocalDataSource.createCategory(
                  newCategory: localValue,
                ),
              ).called(1);
              expect(id, equals(1));

              // cleanup
            },
          );
        },
      );

      group(
        "getCategories",
        () {
          test(
            "given [CategoriesLocalDataSource.getCategories] "
            "when [getCategories] is called "
            "then should call [CategoriesLocalDataSource.getCategories] and return expected list of [CategoryModel]",
            () async {
              // setup
              final categoriesEntityValues = List.generate(
                3,
                (index) => CategoryLocalEntityValue(
                  id: index,
                  name: "name$index",
                ),
              );
              when(
                () => categoryLocalDataSource.getCategories(),
              ).thenAnswer(
                (_) async => categoriesEntityValues,
              );

              // when
              final categories = await repository.getCategories();

              // then
              final expectedCategories = categoriesEntityValues
                  .map(
                    (entityValue) => CategoryModel(
                      id: entityValue.id,
                      name: entityValue.name,
                    ),
                  )
                  .toList();

              verify(
                () => categoryLocalDataSource.getCategories(),
              ).called(1);
              expect(categories, equals(expectedCategories));

              // cleanup
            },
          );
        },
      );

      group(
        "getCategoryById",
        () {
          test(
            "given [id] "
            "when [getCategoryById] is called "
            "then should call [CategoriesLocalDataSource.getCategoryById] with expected arguments and return expected [CategoryModel]",
            () async {
              // setup
              const entityValue = CategoryLocalEntityValue(
                id: 1,
                name: "name",
              );
              when(
                () => categoryLocalDataSource.getCategoryById(
                  id: any(named: "id"),
                ),
              ).thenAnswer(
                (_) async => entityValue,
              );

              // given
              const id = 1;

              // when
              final category = await repository.getCategoryById(
                id: id,
              );

              // then
              final expectedCategory = CategoryModel(
                id: entityValue.id,
                name: entityValue.name,
              );

              verify(
                () => categoryLocalDataSource.getCategoryById(
                  id: id,
                ),
              ).called(1);
              expect(category, equals(expectedCategory));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockCategoriesLocalDataSource extends Mock
    implements CategoriesLocalDataSource {}

class _FakeNewCategoryLocalValue extends Fake
    implements NewCategoryLocalValue {}
