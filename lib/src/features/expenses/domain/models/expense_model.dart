import 'package:equatable/equatable.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';

class ExpenseModel extends Equatable {
  const ExpenseModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.category,
    this.note,
  });

  final int id;
  final DateTime date;
  final int amount;
  final CategoryModel category;
  final String? note;

  @override
  List<Object?> get props => [id, date, amount, note, category];
}
