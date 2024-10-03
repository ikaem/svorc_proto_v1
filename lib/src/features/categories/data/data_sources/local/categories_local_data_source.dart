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
}
