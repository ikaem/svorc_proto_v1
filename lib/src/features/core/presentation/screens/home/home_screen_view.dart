import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/dialog_wrapper.dart';
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
import 'package:svorc_proto_v1/src/features/period_daily_budgets/presentation/widgets/add_month_daily_budget.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';

class HomeScreenView extends ConsumerWidget {
  HomeScreenView({super.key});

  late final GetMonthDailyBudgetControllerProvider
      getMonthDailyBudgetControllerProviderInstance =
      getMonthDailyBudgetControllerProvider(DateTime.now());

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        getMonthDailyBudgetControllerProviderInstance,
        (os, ns) => _onListenDailyBudgetProvider(
              os,
              ns,
              context: context,
              ref: ref,
            ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final AsyncValue<GetMonthDailyBudgetControllerState> state =
                ref.watch(getMonthDailyBudgetControllerProviderInstance);

            return state.when(
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (Object error, StackTrace stackTrace) {
                return const Center(
                  child:
                      Text("There was an issue retrieving month daily budget"),
                );
              },
              data: (GetMonthDailyBudgetControllerState data) {
                final PeriodDailyBudgetModel? budget = data.dailyBudget;

                if (budget == null) {
                  return const Center(
                    child: Text("No daily budget found"),
                  );
                }

                return Column(
                  children: [
                    // TODO revert this
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: HomeScreenTopButtons(),
                    ),
                    HomeScreenBalances(
                      currentMonthDailyBudget: budget,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Expanded(
                      child: HomeScreenRecentExpenses(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );

    // state.when(
    //   data:(data) {

    //   },
    //   error:(error, stackTrace) {

    //   },
    //   loading: loading,
    // );

    // return const Center(
    //   child: Text("Hello"),
    // );
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

  void _onListenDailyBudgetProvider(
    AsyncValue<GetMonthDailyBudgetControllerState>? oldState,
    AsyncValue<GetMonthDailyBudgetControllerState> newState, {
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final state = newState;
    if (state is! AsyncData<GetMonthDailyBudgetControllerState>) return;

    final dailyBudget = state.value.dailyBudget;
    if (dailyBudget == null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogWrapper(
            child: AddMonthDailyBudget(
              onSuccess: () {
                Navigator.of(context).pop();
                ref
                    .read(
                        getMonthDailyBudgetControllerProviderInstance.notifier)
                    .onLoadBudget();
              },
            ),
          );

          // return Dialog(
          //   // child: Text("No daily budget found"),
          //   insetPadding: const EdgeInsets.all(15),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   clipBehavior: Clip.antiAlias,
          //   child: Container(
          //     color: Colors.white,
          //     padding: const EdgeInsets.only(
          //       // TODO not sure if it is needed
          //       // TODO leave for now
          //       // bottom: MediaQuery.of(context).viewInsets.bottom,
          //       bottom: 15,
          //       top: 15,
          //       left: 15,
          //       right: 15,
          //     ),
          //     child: const AddMonthDailyBudget(),
          //   ),
          // );
        },
      );
    }
  }
}

// class _HomeScreenMonthDailyBudgetNotFound extends StatelessWidget {
//   const _HomeScreenMonthDailyBudgetNotFound();

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Text("Current month daily budget not found"),
//         ),
//       ),
//     );
//   }
// }

// class _HomeScreenContentsContainer extends StatelessWidget {
//   const _HomeScreenContentsContainer({
//     super.key,
//     required this.currentMonthDailyBudget,
//   });

//   final PeriodDailyBudgetModel currentMonthDailyBudget;

//   @override
//   Widget build(BuildContext context) {
//     // TODO if keyboard is activated here, there is an overflow. fix it
//     return const Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: HomeScreenTopButtons(),
//             ),
//             HomeScreenBalances(),
//             SizedBox(
//               height: 15,
//             ),
//             Expanded(child: HomeScreenRecentExpenses()),
//           ],
//         ),
//       ),
//     );
//   }
// }


