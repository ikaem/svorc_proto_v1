import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/new_category_local_value.dart';

abstract interface class CategoriesLocalDataSource {
  Future<int> createCategory({
    required NewCategoryLocalValue newCategory,
  });

  Future<List<CategoryLocalEntityValue>> getCategories();

  Future<CategoryLocalEntityValue?> getCategoryById({
    required int id,
  });

  // TODO add delete category data source
  // TODO general category should not be deleted - so probably if id is 1, or category is general

  // TODO also, if we are deleting a category, all expenses for that category will go into general
  // so maybe good to warn a user about that, so they can maybe manually do it?
  // TODO this is a v2 work probably - for now, no categories will be deleted
}
