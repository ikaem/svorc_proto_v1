import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';

abstract class CategoryConverters {
  static CategoryLocalEntityValue toEntityValueFromEntityData({
    required CategoryLocalEntityData entityData,
  }) {
    final CategoryLocalEntityValue value = CategoryLocalEntityValue(
      id: entityData.id,
      name: entityData.name,
    );

    return value;
  }

  // static CategoryModel toModelFromEntityValue({
  //   required CategoryLocalEntityValue entityValue,
  // }) {
  //   final CategoryModel model = CategoryModel(
  //     id: entityValue.id,
  //     name: entityValue.name,
  //     description: entityValue.description,
  //   );

  //   return model;
  // }
}
