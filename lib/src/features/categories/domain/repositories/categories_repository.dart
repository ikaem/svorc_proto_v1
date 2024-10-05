import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/new_category_local_value.dart';

abstract interface class CategoriesRepository {
  Future<int> createCategory({
    required NewCategoryLocalValue newCategory,
  });

  Future<List<CategoryModel>> getCategories();

  Future<CategoryModel?> getCategoryById({
    required int id,
  });
}
