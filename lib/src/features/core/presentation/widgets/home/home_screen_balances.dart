import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_period_balances.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_today_balances.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';

class HomeScreenBalances extends StatelessWidget {
  const HomeScreenBalances({
    super.key,
    required this.currentMonthDailyBudget,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;

  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Text("Balances"),
    // );

    // keep for now
    return const Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: HomeScreenTodayBalances(
        //     accumulation:
        //         successState.balances.currentDayBalance.accumulationValue,
        //     spent: successState.balances.currentDayBalance.spentValue,
        //     remainder: successState.balances.currentDayBalance.remainderValue,
        //   ),
        // ),
        // HomeScreenPeriodBalances(
        //   color: Colors.grey.shade300,
        //   iconData: Icons.calendar_view_week,
        //   accumulation:
        //       successState.balances.currentWeekBalance.accumulationValue,
        //   spent: successState.balances.currentWeekBalance.spentValue,
        //   remainder: successState.balances.currentWeekBalance.remainderValue,
        // ),
        // HomeScreenPeriodBalances(
        //   color: Colors.grey.shade400,
        //   iconData: Icons.calendar_view_month,
        //   accumulation:
        //       successState.balances.currentMonthBalance.accumulationValue,
        //   spent: successState.balances.currentMonthBalance.spentValue,
        //   remainder: successState.balances.currentMonthBalance.remainderValue,
        // )
      ],
    );
  }
}
