import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_period_balances.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_today_balances.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/application/controllers/get_current_month_balances/get_current_month_balances_controller.dart';

class HomeScreenBalances extends ConsumerWidget {
  HomeScreenBalances({
    super.key,
    required this.currentMonthDailyBudget,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;

  late final GetCurrentMonthBalancesControllerProvider
      getCurrentMonthBalancesControllerProviderInstance =
      getCurrentMonthBalancesControllerProvider(currentMonthDailyBudget);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getCurrentMonthBalancesControllerProviderInstance);

    return state.when(
      data: (data) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: HomeScreenTodayBalances(
                accumulation: data.balances.currentDayBalance.accumulationValue,
                spent: data.balances.currentDayBalance.spentValue,
                remainder: data.balances.currentDayBalance.remainderValue,
              ),
            ),
            HomeScreenPeriodBalances(
              color: Colors.grey.shade300,
              iconData: Icons.calendar_view_week,
              accumulation: data.balances.currentWeekBalance.accumulationValue,
              spent: data.balances.currentWeekBalance.spentValue,
              remainder: data.balances.currentWeekBalance.remainderValue,
            ),
            HomeScreenPeriodBalances(
              color: Colors.grey.shade400,
              iconData: Icons.calendar_view_month,
              accumulation: data.balances.currentMonthBalance.accumulationValue,
              spent: data.balances.currentMonthBalance.spentValue,
              remainder: data.balances.currentMonthBalance.remainderValue,
            )
          ],
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text("There was an issue retrieving month daily budget"),
        );
      },
    );

    // -------------------
    // return const Center(
    //   child: Text("Balances"),
    // );

    // keep for now
    // return const Column(
    //   children: [
    //     // Padding(
    //     //   padding: const EdgeInsets.all(15.0),
    //     //   child: HomeScreenTodayBalances(
    //     //     accumulation:
    //     //         successState.balances.currentDayBalance.accumulationValue,
    //     //     spent: successState.balances.currentDayBalance.spentValue,
    //     //     remainder: successState.balances.currentDayBalance.remainderValue,
    //     //   ),
    //     // ),
    //     // HomeScreenPeriodBalances(
    //     //   color: Colors.grey.shade300,
    //     //   iconData: Icons.calendar_view_week,
    //     //   accumulation:
    //     //       successState.balances.currentWeekBalance.accumulationValue,
    //     //   spent: successState.balances.currentWeekBalance.spentValue,
    //     //   remainder: successState.balances.currentWeekBalance.remainderValue,
    //     // ),
    //     // HomeScreenPeriodBalances(
    //     //   color: Colors.grey.shade400,
    //     //   iconData: Icons.calendar_view_month,
    //     //   accumulation:
    //     //       successState.balances.currentMonthBalance.accumulationValue,
    //     //   spent: successState.balances.currentMonthBalance.spentValue,
    //     //   remainder: successState.balances.currentMonthBalance.remainderValue,
    //     // )
    //   ],
    // );
  }
}
