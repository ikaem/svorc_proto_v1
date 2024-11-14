import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/add_month_daily_budget_dialog.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_balances.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_recent_expenses.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/home_screen_top_buttons.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/bloc/cubits/get_recent_expenses/get_recent_expenses_cubit.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_recent_expenses_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/bloc/cubits/get_month_daily_budget/get_month_daily_budget_cubit.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/get_month_daily_budget/get_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';

class HomeScreenView extends ConsumerWidget {
  HomeScreenView({super.key});

  late final GetMonthDailyBudgetControllerProvider
      getCurrentMonthDailyBudgetControllerProvider =
      getMonthDailyBudgetControllerProvider(DateTime.now());

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        getCurrentMonthDailyBudgetControllerProvider,
        (os, ns) => _onListenDailyBudgetProvider(
              os,
              ns,
              context: context,
            ));

    final AsyncValue<GetMonthDailyBudgetControllerState> state =
        ref.watch(getCurrentMonthDailyBudgetControllerProvider);

    return const Center(
      child: Text("Hello"),
    );
    // return BlocConsumer<GetMonthDailyBudgetCubit,
    //     GetMonthDailyBudgetCubitState>(
    //   builder: (context, state) {
    //     switch (state) {
    //       case GetMonthDailyBudgetCubitStateInitial _:
    //         return const Center(child: Text("Initial stuff"));
    //       case GetMonthDailyBudgetCubitStateLoading _:
    //         return const Center(child: CircularProgressIndicator());
    //       case GetMonthDailyBudgetCubitStateSuccess state:
    //         // return const Center(child: Text("Success"));
    //         return _HomeScreenContentsContainer(
    //           currentMonthDailyBudget: state.dailyBudget,
    //         );
    //       case GetMonthDailyBudgetCubitStateFailure _:
    //         return const Center(child: Text("Failure"));
    //       case GetMonthDailyBudgetCubitStateNotFound _:
    //         // return const Center(child: Text("Not Found"));
    //         return const _HomeScreenMonthDailyBudgetNotFound();
    //     }
    //   },
    //   listener: (context, state) {
    //     if (state is! GetMonthDailyBudgetCubitStateNotFound) {
    //       return;
    //     }

    //     showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (context) {
    //         return AddMonthDailyBudgetDialog(
    //           onClose: () {
    //             // TODO this is not really used
    //             Navigator.of(context).pop();
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
  }
}

class _HomeScreenMonthDailyBudgetNotFound extends StatelessWidget {
  const _HomeScreenMonthDailyBudgetNotFound();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Current month daily budget not found"),
        ),
      ),
    );
  }
}

class _HomeScreenContentsContainer extends StatelessWidget {
  const _HomeScreenContentsContainer({
    super.key,
    required this.currentMonthDailyBudget,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;

  @override
  Widget build(BuildContext context) {
    // TODO if keyboard is activated here, there is an overflow. fix it
    return const Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: HomeScreenTopButtons(),
          ),
          HomeScreenBalances(),
          SizedBox(
            height: 15,
          ),
          Expanded(child: HomeScreenRecentExpenses()),
        ],
      )),
    );
  }
}

void _onListenDailyBudgetProvider(
  AsyncValue<GetMonthDailyBudgetControllerState>? oldState,
  AsyncValue<GetMonthDailyBudgetControllerState> newState, {
  required BuildContext context,
}) {
  final state = newState;
  if (state is! AsyncData<GetMonthDailyBudgetControllerState>) return;

  final dailyBudget = state.value.dailyBudget;
  if (dailyBudget == null) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          child: Text("No daily budget found"),
        );
      },
    );
  }
}
