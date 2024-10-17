import 'package:equatable/equatable.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';

class MonthBalancesValue extends Equatable {
  const MonthBalancesValue({
    required this.currentMonthDailyBudget,
    required this.currentWeekBalance,
    required this.currentMonthBalance,
    required this.currentDayBalance,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;

  final WeekBalanceValue currentWeekBalance;
  final MonthBalanceValue currentMonthBalance;
  final DateBalanceValue currentDayBalance;

  @override
  List<Object> get props => [
        currentMonthDailyBudget,
        currentWeekBalance,
        currentMonthBalance,
        currentDayBalance,
      ];
}






// TODO old

// class HomeScreenExpensesStateValue extends Equatable {
//   const HomeScreenExpensesStateValue({
//     required this.thisMonthDailyBudget,
//     required this.todayAmounts,
//     required this.thisWeekAmounts,
//     required this.thisMonthAmounts,
//   });

//   final int thisMonthDailyBudget;
//   final HomeScreenPeriodAmounts todayAmounts;
//   final HomeScreenPeriodAmounts thisWeekAmounts;
//   final HomeScreenPeriodAmounts thisMonthAmounts;

//   @override
//   List<Object> get props => [
//         todayAmounts,
//         thisWeekAmounts,
//         thisMonthAmounts,
//       ];
// }

// class HomeScreenPeriodAmounts extends Equatable {
//   const HomeScreenPeriodAmounts({
//     required this.period,
//     required this.spent,
//     required this.remainder,
//     required this.accumulation,
//   });

//   final Period period;
//   final int spent;
//   final int remainder;
//   final int accumulation;

//   @override
//   List<Object> get props => [
//         period,
//         spent,
//         remainder,
//         accumulation,
//       ];
// }


/* 



import 'dart:math';

void main() {
  final date = DateTime.now();

  final day = date.day;

  print(day);

  final random = Random();

  final randomNumber = random.nextInt(day);

  final randomNr = random.nextInt(day);

  final randomDateUpToToday = DateTime(date.year, date.month, randomNr);

  print(randomDateUpToToday);
}









 */