import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  // TODO this can keep possibly some color, and some icon, but maybe as an extension? we will see

  const CategoryModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
