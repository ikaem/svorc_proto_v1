// TODO rename all controller state classes controller_state_data - because thats what it is - state data

part of "get_current_month_balances_controller.dart";

class GetCurrentMonthBalancesControllerStateData extends Equatable {
  const GetCurrentMonthBalancesControllerStateData({
    required this.balances,
  });

  final MonthBalancesValue balances;

  @override
  List<Object?> get props => [balances];
}
