import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/add_expense.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/edit_month_daily_budget.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/modal_bottom_sheet_wrapper.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/presentation/widgets/edit_month_daily_budget_new.dart';
import 'package:svorc_proto_v1/src/features/reports/presentation/screens/balance_report_screen.dart';

class HomeScreenTopButtons extends StatelessWidget {
  const HomeScreenTopButtons({
    super.key,
    required this.currentMonthDailyBudget,
    required this.onLoadCurrentMonthDailyBudget,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;
  // TODO maybe this is silly
  final VoidCallback onLoadCurrentMonthDailyBudget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      // TODO could use intrinsics height here, but it is expensive
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO all of these should be extracted in their own widgets
          Flexible(
            child: _CurrentMonthDailyBudget(
              currentMonthDailyBudget: currentMonthDailyBudget,
              onLoadCurrentMonthDailyBudget: onLoadCurrentMonthDailyBudget,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Flexible(
            child: _BalanceReport(),
          ),
          const SizedBox(
            width: 15,
          ),
          const Flexible(
            child: _AddExpense(),
          ),
        ],
      ),
    );
  }
}

class _AddExpense extends StatelessWidget {
  const _AddExpense();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          // NOTE: TOOK from here https://stackoverflow.com/a/57515977/9661910
          // and here https://stackoverflow.com/a/75572237/9661910
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) {
            return ModalBottomSheetWrapper(
              child: AddExpense(
                onClose: () => Navigator.of(context).pop(),
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        // height: 150,
        // width: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
        // color: Colors.grey,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.add_box_rounded,
              color: Colors.white,
              size: 64,
            ),
            Text(
              "Add Expense",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceReport extends StatelessWidget {
  const _BalanceReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const BalanceReportScreen();
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        // height: 150,
        // width: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        // color: Colors.grey.shade200,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.analytics,
              size: 64,
            ),
            Text(
              "Balance Report",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentMonthDailyBudget extends StatelessWidget {
  const _CurrentMonthDailyBudget({
    required this.currentMonthDailyBudget,
    required this.onLoadCurrentMonthDailyBudget,
  });

  final PeriodDailyBudgetModel currentMonthDailyBudget;
  final VoidCallback onLoadCurrentMonthDailyBudget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      // this should be a third of screen, or a bit less
      // TODO not sure if this can be done porgrammatically with styling? - need to check to change size of container reposnisvely - maybe with expanded or flexible
      // height: 150,
      // width: 50,
      // color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Budget",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            "DECEMBER 2021",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            // TODO if add EUR , there is overflow - fix it
            "${currentMonthDailyBudget.amount}",
            style: const TextStyle(
              fontSize: 24,
              // color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                // TODO these should maybe also be part of some function that wrapps showModalBottomSheet, and we use it?

                isScrollControlled: true,
                isDismissible: false,
                context: context,
                builder: (context) {
                  return ModalBottomSheetWrapper(
                    child: EditMonthDailyBudgetNew(
                      // onCancelEdit: () => Navigator.of(context).pop(),
                      // onSaveEdit: () => Navigator.of(context).pop(),
                      onClose: () {
                        // TODO this is a bit silly
                        // maybe top button this could call its own stuff, so only top button is reloaded.
                        // this way, everything is reloaded. come back to this
                        onLoadCurrentMonthDailyBudget();
                        Navigator.of(context).pop();
                        // TODO
                      },
                      currentMonthDailyBudget: currentMonthDailyBudget,
                    ),
                  );
                },
              );

              // showModalBottomSheet(
              //   // NOTE: TOOK from here https://stackoverflow.com/a/57515977/9661910
              //   // and here https://stackoverflow.com/a/75572237/9661910
              //   // TODO use this if there is anything scrollable
              //   isScrollControlled: true,
              //   isDismissible: false,
              //   context: context,
              //   builder: (context) {
              //     // TODO create ModalBottomSheetWrapper in same style as DialogWrapper
              //     return Container(
              //       // height: 200,
              //       color: Colors.white,
              //       // padding: const EdgeInsets.all(15.0),
              //       padding: EdgeInsets.only(
              //         bottom: MediaQuery.of(context).viewInsets.bottom,
              //         top: 15,
              //         left: 15,
              //         right: 15,
              //       ),
              //       // child: const _HomeScreenAddExpense(),
              //       // child: const Text("Edit Budget"),
              //       child: const EditMonthDailyBudget(),
              //     );
              //   },
              // );
            },
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.grey.shade600,
                  size: 12,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Edit Budget",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
