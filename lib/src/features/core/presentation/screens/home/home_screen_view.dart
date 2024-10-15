import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            builder: (context) {
              return const _Some();
            },
          );
        }
      },
    );
  }
}

class _Some extends StatelessWidget {
  const _Some({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ADD DAILY BUDGET",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
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
