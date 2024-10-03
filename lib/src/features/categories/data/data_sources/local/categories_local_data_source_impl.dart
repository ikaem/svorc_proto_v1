import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/features/categories/data/data_sources/local/categories_local_data_source.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/new_category_local_value.dart';
import 'package:svorc_proto_v1/src/features/categories/utils/converters/category_converters.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_database_wrapper.dart';

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  CategoriesLocalDataSourceImpl({
    required DriftDatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;

  final DriftDatabaseWrapper _databaseWrapper;

  @override
  Future<int> createCategory(
      {required NewCategoryLocalValue newCategory}) async {
    // TODO: implement createCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryLocalEntityValue>> getCategories() async {
    final select = _databaseWrapper.categoryRepo.select();

    final entityDatas = await select.get();

    final entityValues = entityDatas
        .map((ed) =>
            CategoryConverters.toEntityValueFromEntityData(entityData: ed))
        .toList();

    return entityValues;
  }

  @override
  Future<CategoryLocalEntityValue?> getCategoryById({required int id}) async {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }
}
