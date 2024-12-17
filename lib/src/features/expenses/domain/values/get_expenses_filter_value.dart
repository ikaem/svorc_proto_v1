// TODO move to values folder
import 'package:equatable/equatable.dart';

class GetExpensesFilterValue extends Equatable {
  const GetExpensesFilterValue({
    this.minDate,
    this.maxDate,
    this.limit,
    this.offset,
  });

  final DateTime? minDate;
  final DateTime? maxDate;
  final int? limit;
  // offset makes sense to provide only with limit. it limit is not provided, offset will not be applied, even if it is provided
  final int? offset;

  @override
  List<Object?> get props => [minDate, maxDate];
}
