import 'package:equatable/equatable.dart';

class CategoryLocalEntityValue extends Equatable {
  const CategoryLocalEntityValue({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
