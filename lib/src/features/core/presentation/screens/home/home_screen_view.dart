import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_balances.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_recent_expenses.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_top_buttons.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/bloc/cubits/get_recent_expenses/get_recent_expenses_cubit.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_recent_expenses_use_case.dart';
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

class HomeScreenContentsContainer extends StatelessWidget {
  const HomeScreenContentsContainer({
    super.key,
    required this.currentMonthDailyBudget,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;

  @override
  Widget build(BuildContext context) {
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
          BlocProvider(
            create: (context) {
              final ExpensesRepository expensesRepository =
                  context.read<ExpensesRepository>();

              final GetRecentExpensesUseCase getRecentExpensesUseCase =
                  GetRecentExpensesUseCase(
                expensesRepository: expensesRepository,
              );

              final GetRecentExpensesCubit getRecentExpensesCubit =
                  GetRecentExpensesCubit(
                getRecentExpensesUseCase: getRecentExpensesUseCase,
              );

              return getRecentExpensesCubit..onLoadRecentExpenses();
            },
            child: const Expanded(child: HomeScreenRecentExpenses()),
          ),
        ],
      )),
    );
  }
}
