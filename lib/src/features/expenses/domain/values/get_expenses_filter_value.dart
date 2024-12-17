// TODO move to values folder
import 'package:equatable/equatable.dart';

class GetExpensesFilterValue extends Equatable {
  const GetExpensesFilterValue({
    this.minDate,
    this.maxDate,
    this.limit,
  });

  final DateTime? minDate;
  final DateTime? maxDate;
  final int? limit;

  @override
  List<Object?> get props => [minDate, maxDate];
}
