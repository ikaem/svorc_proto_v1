import 'package:equatable/equatable.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';

class HomeScreenBalancesValue extends Equatable {
  const HomeScreenBalancesValue({
    required this.thisMonthDailyBudget,
    required this.thisWeekBalance,
    required this.thisMonthBalance,
    required this.todayBalance,
  });

  final PeriodDailyBudgetModel thisMonthDailyBudget;

  final WeekBalanceValue thisWeekBalance;
  final MonthBalanceValue thisMonthBalance;
  final DateBalanceValue todayBalance;

  @override
  List<Object> get props => [
        thisMonthDailyBudget,
        thisWeekBalance,
        thisMonthBalance,
        todayBalance,
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