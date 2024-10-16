import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/add_monthly_budget_dialog.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/home_screen_balances_report/home_screen_balances_report_cubit.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBalancesReportCubit,
        HomeScreenBalancesReportCubitState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: _HomeScreenViewBody(
              state: state,
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state
            is HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              // TODO future work, prevent closing this in any way by user
              return AddMonthlyBudgetDialog(
                onClose: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
      },
    );
  }
}

class _HomeScreenViewBody extends StatelessWidget {
  const _HomeScreenViewBody({
    required this.state,
  });

  final HomeScreenBalancesReportCubitState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      HomeScreenBalancesReportCubitStateInitial() =>
        const Center(child: Text("Initial stuff")),
      (HomeScreenBalancesReportCubitStateLoading _) => const Center(
          child: CircularProgressIndicator(),
        ),
      (HomeScreenBalancesReportCubitStateSuccess _) => const Center(
          child: Text("Success"),
        ),
      // TODO: Handle this case.
      (HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound _) =>
        const Center(
          child: Text("Not Found"),
        ),
      (HomeScreenBalancesReportCubitStateFailure _) => const Center(
          child: Text("Failure"),
        ),
    };
  }
}
