import 'package:equatable/equatable.dart';

class ExpenseLocalEntityValue extends Equatable {
  const ExpenseLocalEntityValue({
    required this.id,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.note,
    // TODO not needed for now at least
    // required this.createdAt,
    // required this.updatedAt,
  });

  final int id;
  final int amount;
  final DateTime date;
  final int categoryId;
  final String? note;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        amount,
        date,
        categoryId,
        note,
      ];
}
