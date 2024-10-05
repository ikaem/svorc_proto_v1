import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/new_category_local_value.dart';
import 'package:svorc_proto_v1/src/features/categories/utils/converters/category_converters.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  const CategoriesRepositoryImpl({
    required CategoriesLocalDataSource categoryLocalDataSource,
  }) : _categoryLocalDataSource = categoryLocalDataSource;

  final CategoriesLocalDataSource _categoryLocalDataSource;

  @override
  Future<int> createCategory({
    required NewCategoryLocalValue newCategory,
  }) async {
    final id = await _categoryLocalDataSource.createCategory(
      newCategory: newCategory,
    );

    return id;
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final entityValues = await _categoryLocalDataSource.getCategories();

    final models = entityValues.map((entityValue) {
      return CategoryConverters.toModelFromEntityValue(
        entityValue: entityValue,
      );
    }).toList();

    return models;
  }

  @override
  Future<CategoryModel?> getCategoryById({
    required int id,
  }) async {
    final entityValue = await _categoryLocalDataSource.getCategoryById(
      id: id,
    );

    if (entityValue == null) {
      return null;
    }

    final model = CategoryConverters.toModelFromEntityValue(
      entityValue: entityValue,
    );
    return model;
  }
}
