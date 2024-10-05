import 'package:equatable/equatable.dart';

class NewExpenseLocalValue extends Equatable {
  const NewExpenseLocalValue({
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.note,
  });

  final int amount;
  final DateTime date;
  final int categoryId;
  final String? note;

  @override
  List<Object?> get props => [amount, date, categoryId, note];
}
