import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen_view.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/bloc/cubits/get_month_daily_budget/get_month_daily_budget_cubit.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetMonthDailyBudgetCubit>(
      create: (context) {
        final PeriodDailyBudgetsRepository budgetsRepository =
            context.read<PeriodDailyBudgetsRepository>();
        final GetMonthDailyBudgetUseCase monthDailyBudgetUseCase =
            GetMonthDailyBudgetUseCase(budgetsRepository);

        final GetMonthDailyBudgetCubit monthDailyBudgetCubit =
            GetMonthDailyBudgetCubit(
          getMonthDailyBudgetUseCase: monthDailyBudgetUseCase,
        );

        return monthDailyBudgetCubit..onLoadBudget(date: DateTime.now());
      },
      child: const HomeScreenView(),
    );

    // TODO old
    // return BlocProvider<GetCurrentMonthBalancesCubit>(
    //   create: (context) {
    //     final ExpensesRepository expensesRepository =
    //         context.read<ExpensesRepository>();
    //     // final PeriodDailyBudgetsRepository budgetsRepository =
    //     //     context.read<PeriodDailyBudgetsRepository>();

    //     final GetMonthBalancesUseCase balancesUseCase =
    //         GetMonthBalancesUseCase(expensesRepository);
    //     // final GetMonthDailyBudgetUseCase monthDailyBudgetUseCase =
    //     //     GetMonthDailyBudgetUseCase(budgetsRepository);

    //     final GetCurrentMonthBalancesCubit balancesReportCubit =
    //         GetCurrentMonthBalancesCubit(
    //       getHomeScreenBalancesUseCase: balancesUseCase,
    //       // getMonthDailyBudgetUseCase: monthDailyBudgetUseCase,
    //     )..onLoadBalances(
    //             // TODO temp only
    //             currentMonthDailyBudget: PeriodDailyBudgetModel(
    //               id: 1,
    //               periodStart: DateTime.now(),
    //               periodEnd: DateTime.now(),
    //               amount: 1000,
    //               period: Period.month,
    //             ),
    //           );
    //     return balancesReportCubit;
    //   },
    //   child: const HomeScreenView(),
    // );
  }
}
