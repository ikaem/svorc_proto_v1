import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/add_expense.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/edit_month_daily_budget.dart';
import 'package:svorc_proto_v1/src/features/reports/presentation/screens/balance_report_screen.dart';

class HomeScreenTopButtons extends StatelessWidget {
  const HomeScreenTopButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      // TODO could use intrinsics height here, but it is expensive
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
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
                  const Text(
                    "6 EUR",
                    style: TextStyle(
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
                        // NOTE: TOOK from here https://stackoverflow.com/a/57515977/9661910
                        // and here https://stackoverflow.com/a/75572237/9661910
                        // TODO use this if there is anything scrollable
                        isScrollControlled: true,
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          return Container(
                            // height: 200,
                            color: Colors.white,
                            // padding: const EdgeInsets.all(15.0),
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              top: 15,
                              left: 15,
                              right: 15,
                            ),
                            // child: const _HomeScreenAddExpense(),
                            // child: const Text("Edit Budget"),
                            child: const EditMonthDailyBudget(),
                          );
                        },
                      );
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
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                // final nowDate = DateTime.now();

                // DateTime.april;

                // final january = DateTime(2024, 1, 1);
                // // final firstMillisecondOfJanuary = DateTime(
                // //     january.year, january.month, january.day, 0, 0, 0, 0);

                // print("nowDate: $nowDate");

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
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  // NOTE: TOOK from here https://stackoverflow.com/a/57515977/9661910
                  // and here https://stackoverflow.com/a/75572237/9661910
                  isScrollControlled: true,
                  isDismissible: false,
                  context: context,
                  builder: (context) {
                    return Container(
                      // height: 200,
                      color: Colors.white,
                      // padding: const EdgeInsets.all(15.0),
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 15,
                        left: 15,
                        right: 15,
                      ),
                      child: const AddExpense(),
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
            ),
          ),
        ],
      ),
    );
  }
}
