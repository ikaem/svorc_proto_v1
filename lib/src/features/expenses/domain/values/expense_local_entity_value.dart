import 'package:equatable/equatable.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/values/category_local_entity_value.dart';

class ExpenseLocalEntityValue extends Equatable {
  const ExpenseLocalEntityValue({
    required this.id,
    required this.amount,
    required this.date,
    // required this.categoryId,
    required this.category,
    required this.note,
    // TODO not needed for now at least
    // required this.createdAt,
    // required this.updatedAt,
  });

  final int id;
  final int amount;
  final DateTime date;
  // final int categoryId;
  final CategoryLocalEntityValue category;
  final String? note;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        amount,
        date,
        category,
        note,
      ];
}
