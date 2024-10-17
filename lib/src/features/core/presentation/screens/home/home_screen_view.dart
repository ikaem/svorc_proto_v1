import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/add_monthly_budget_dialog.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCurrentMonthBalancesCubit,
        GetCurrentMonthBalancesCubitState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: _HomeScreenViewBody(
              state: state,
            ),
          ),
        );
      },
      // TODO not needed
      listener: (context, state) {},
      // listener: (context, state) {
      //   if (state
      //       is HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound) {
      //     showDialog(
      //       context: context,
      //       barrierDismissible: false,
      //       builder: (context) {
      //         // TODO future work, prevent closing this in any way by user
      //         return AddMonthlyBudgetDialog(
      //           onClose: () {
      //             Navigator.of(context).pop();
      //           },
      //         );
      //       },
      //     );
      //   }
      // },
    );
  }
}

class _HomeScreenViewBody extends StatelessWidget {
  const _HomeScreenViewBody({
    required this.state,
  });

  final GetCurrentMonthBalancesCubitState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      GetCurrentMonthBalancesCubitStateInitial() =>
        const Center(child: Text("Initial stuff")),
      (GetCurrentMonthBalancesCubitStateLoading _) => const Center(
          child: CircularProgressIndicator(),
        ),
      (GetCurrentMonthBalancesCubitStateSuccess _) => const Center(
          child: Text("Success"),
        ),
      // TODO: Handle this case.
      // (HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound _) =>
      //   const Center(
      //     child: Text("Not Found"),
      //   ),
      (GetCurrentMonthBalancesCubitStateFailure _) => const Center(
          child: Text("Failure"),
        ),
    };
  }
}
