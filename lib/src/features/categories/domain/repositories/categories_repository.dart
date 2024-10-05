import 'package:svorc_proto_v1/src/features/categories/domain/values/new_category_local_value.dart';
import 'package:svorc_proto_v1/src/features/expenses/presentation/expenses_screen.dart';

abstract interface class CategoriesRepository {
  Future<int> createCategory({
    required NewCategoryLocalValue newCategory,
  });

  Future<List<CategoryModel>> getCategories();

  Future<CategoryModel?> getCategoryById({
    required int id,
  });
}
