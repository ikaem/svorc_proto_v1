import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen_old.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/add_monthly_budget_dialog.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/bloc/cubits/get_month_daily_budget/get_month_daily_budget_cubit.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetMonthDailyBudgetCubit,
        GetMonthDailyBudgetCubitState>(
      builder: (context, state) {
        // return switch (state) {
        //   // TODO: Handle this case.
        //   (GetMonthDailyBudgetCubitStateInitial _) =>
        //     const Center(child: Text("Initial stuff")),
        //   (GetMonthDailyBudgetCubitStateLoading _) => const Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   (GetMonthDailyBudgetCubitStateSuccess _) => const Center(
        //       child: Text("Success"),
        //     ),
        //   (GetMonthDailyBudgetCubitStateFailure _) => const Center(
        //       child: Text("Failure"),
        //     ),
        //   // TODO: Handle this case.
        //   (GetMonthDailyBudgetCubitStateMonthDailyBudgetNotFound _) =>
        //     const Center(
        //       child: Text("Not Found"),
        //     ),
        // };

        switch (state) {
          case GetMonthDailyBudgetCubitStateInitial state:
            return const Center(child: Text("Initial stuff"));
          case GetMonthDailyBudgetCubitStateLoading state:
            return const Center(child: CircularProgressIndicator());
          case GetMonthDailyBudgetCubitStateSuccess state:
            // return const Center(child: Text("Success"));
            return HomeScreenContentsContainer(
              currentMonthDailyBudget: state.dailyBudget,
            );
          case GetMonthDailyBudgetCubitStateFailure state:
            return const Center(child: Text("Failure"));
          case GetMonthDailyBudgetCubitStateMonthDailyBudgetNotFound state:
            return const Center(child: Text("Not Found"));
        }
      },
      listener: (context, state) {},
    );

    // TODO old
    // return BlocConsumer<GetCurrentMonthBalancesCubit,
    //     GetCurrentMonthBalancesCubitState>(
    //   builder: (context, state) {
    //     return Scaffold(
    //       body: SafeArea(
    //         child: _HomeScreenViewBody(
    //           state: state,
    //         ),
    //       ),
    //     );
    //   },
    //   // TODO not needed
    //   listener: (context, state) {},
    //   // listener: (context, state) {
    //   //   if (state
    //   //       is HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound) {
    //   //     showDialog(
    //   //       context: context,
    //   //       barrierDismissible: false,
    //   //       builder: (context) {
    //   //         // TODO future work, prevent closing this in any way by user
    //   //         return AddMonthlyBudgetDialog(
    //   //           onClose: () {
    //   //             Navigator.of(context).pop();
    //   //           },
    //   //         );
    //   //       },
    //   //     );
    //   //   }
    //   // },
    // );
  }
}

// class _HomeScreenViewBody extends StatelessWidget {
//   const _HomeScreenViewBody({
//     required this.state,
//   });

//   final GetCurrentMonthBalancesCubitState state;

//   @override
//   Widget build(BuildContext context) {
//     return switch (state) {
//       GetCurrentMonthBalancesCubitStateInitial() =>
//         const Center(child: Text("Initial stuff")),
//       (GetCurrentMonthBalancesCubitStateLoading _) => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       (GetCurrentMonthBalancesCubitStateSuccess _) => const Center(
//           child: Text("Success"),
//         ),
//       // TODO: Handle this case.
//       // (HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound _) =>
//       //   const Center(
//       //     child: Text("Not Found"),
//       //   ),
//       (GetCurrentMonthBalancesCubitStateFailure _) => const Center(
//           child: Text("Failure"),
//         ),
//     };
//   }
// }

// TODO move to its own

class HomeScreenContentsContainer extends StatelessWidget {
  const HomeScreenContentsContainer({
    super.key,
    required this.currentMonthDailyBudget,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;

  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Text("Home screen container"),
    // );
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: HomeScreenTopButtons(),
          ),
          BlocProvider<GetCurrentMonthBalancesCubit>(
            create: (context) {
              final ExpensesRepository expensesRepository =
                  context.read<ExpensesRepository>();
              final GetMonthBalancesUseCase getMonthBalancesUseCase =
                  GetMonthBalancesUseCase(
                expensesRepository: expensesRepository,
              );

              final getCurrentMonthBalancesCubit = GetCurrentMonthBalancesCubit(
                getHomeScreenBalancesUseCase: getMonthBalancesUseCase,
              );

              return getCurrentMonthBalancesCubit
                ..onLoadBalances(
                    currentMonthDailyBudget: currentMonthDailyBudget);
            },
            child: const HomeScreenBalances(),
          ),
          const SizedBox(
            height: 15,
          ),
          const Expanded(child: HomeScreenRecentExpenses()),
        ],
      )),
    );
  }
}

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
