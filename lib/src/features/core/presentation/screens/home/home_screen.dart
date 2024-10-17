import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen_view.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/home_screen_balances_report/home_screen_balances_report_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_home_screen_balances_use_case.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenBalancesReportCubit>(
      create: (context) {
        final ExpensesRepository expensesRepository =
            context.read<ExpensesRepository>();
        // final PeriodDailyBudgetsRepository budgetsRepository =
        //     context.read<PeriodDailyBudgetsRepository>();

        final GetHomeScreenBalancesUseCase balancesUseCase =
            GetHomeScreenBalancesUseCase(expensesRepository);
        // final GetMonthDailyBudgetUseCase monthDailyBudgetUseCase =
        //     GetMonthDailyBudgetUseCase(budgetsRepository);

        final HomeScreenBalancesReportCubit balancesReportCubit =
            HomeScreenBalancesReportCubit(
          getHomeScreenBalancesUseCase: balancesUseCase,
          // getMonthDailyBudgetUseCase: monthDailyBudgetUseCase,
        )..onLoadBalances(
                // TODO temp only
                currentMonthDailyBudget: PeriodDailyBudgetModel(
                  id: 1,
                  periodStart: DateTime.now(),
                  periodEnd: DateTime.now(),
                  amount: 1000,
                  period: Period.month,
                ),
              );
        return balancesReportCubit;
      },
      child: const HomeScreenView(),
    );
  }
}
