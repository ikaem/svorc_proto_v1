import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen_old.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_period_balances.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_today_balances.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';

class HomeScreenBalances extends StatelessWidget {
  const HomeScreenBalances({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentMonthBalancesCubit,
        GetCurrentMonthBalancesCubitState>(
      builder: (context, state) {
        if (state is GetCurrentMonthBalancesCubitStateInitial) {
          return const Center(child: SizedBox());
        }

        if (state is GetCurrentMonthBalancesCubitStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetCurrentMonthBalancesCubitStateFailure) {
          return const Center(child: Text("There was an issue loading data"));
        }

        final GetCurrentMonthBalancesCubitStateSuccess successState =
            state as GetCurrentMonthBalancesCubitStateSuccess;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: HomeScreenTodayBalances(
                accumulation:
                    successState.balances.currentDayBalance.accumulationValue,
                spent: successState.balances.currentDayBalance.spentValue,
                remainder:
                    successState.balances.currentDayBalance.remainderValue,
              ),
            ),
            HomeScreenPeriodBalances(
              color: Colors.grey.shade300,
              iconData: Icons.calendar_view_week,
              accumulation:
                  successState.balances.currentWeekBalance.accumulationValue,
              spent: successState.balances.currentWeekBalance.spentValue,
              remainder:
                  successState.balances.currentWeekBalance.remainderValue,
            ),
            HomeScreenPeriodBalances(
              color: Colors.grey.shade400,
              iconData: Icons.calendar_view_month,
              accumulation:
                  successState.balances.currentMonthBalance.accumulationValue,
              spent: successState.balances.currentMonthBalance.spentValue,
              remainder:
                  successState.balances.currentMonthBalance.remainderValue,
            )
          ],
        );
      },
    );
  }
}
