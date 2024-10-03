import 'package:equatable/equatable.dart';

class NewCategoryLocalValue extends Equatable {
  const NewCategoryLocalValue({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [
        name,
      ];
}
