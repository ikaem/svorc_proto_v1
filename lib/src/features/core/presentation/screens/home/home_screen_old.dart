import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:svorc_proto_v1/src/features/expenses/presentation/expenses_screen.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/presentation/screens/balance_report_screen.dart';

class HomeScreenOld extends StatefulWidget {
  const HomeScreenOld({super.key});

  @override
  State<HomeScreenOld> createState() => _HomeScreenOldState();
}

class _HomeScreenOldState extends State<HomeScreenOld> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // TODO not sure this should be here
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Builder(builder: (context) {
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return Dialog(
          //       insetPadding: const EdgeInsets.all(15),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(4),
          //       ),
          //       child: Container(
          //         // height: 500,
          //         // width: 200,
          //         // decoration: BoxDecoration(
          //         //   border: Border.all(
          //         //     color: Colors.grey.shade300,
          //         //   ),
          //         //   borderRadius: BorderRadius.circular(4),
          //         // ),
          //         color: Colors.white,
          //         // padding: const EdgeInsets.all(15.0),
          //         padding: EdgeInsets.only(
          //           bottom: MediaQuery.of(context).viewInsets.bottom,
          //           top: 15,
          //           left: 15,
          //           right: 15,
          //         ),
          //         child: const _HomeScreenEditDailyBudget(),
          //         // child: _HomeScreenMonthSelector(
          //         //   onMonthSelection: (SelectedMonth? selectedMonth) {
          //         //     return Navigator.pop(context, selectedMonth);
          //         //   },
          //         // ),
          //       ),
          //     );
          //   },
          // );

          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return const Center();
          //   },
          // );

          return const Center(
            child: CircularProgressIndicator(),
          );
        }),

        // TODO real
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // top buttons, divider, today report
        //     const Padding(
        //       padding: EdgeInsets.all(15.0),
        //       child: Column(
        //         // crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           _HomeScreenTopButtons(),
        //           Divider(
        //             height: 30,
        //           ),
        //           // this is now daily report
        //           _HomeScreenTodayBalances()
        //         ],
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 15,
        //     ),

        //     // week and month report
        //     _HomeScreenPeriodBalances(
        //       color: Colors.grey.shade300,
        //       iconData: Icons.calendar_view_week,
        //     ),
        //     _HomeScreenPeriodBalances(
        //       color: Colors.grey.shade400,
        //       iconData: Icons.calendar_view_month,
        //     ),

        //     const SizedBox(
        //       height: 15,
        //     ),

        //     // recent expenses
        //     const Expanded(
        //       child: _HomeScreenRecentExpenses(),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class _HomeScreenRecentExpenses extends StatelessWidget {
  const _HomeScreenRecentExpenses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade500,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "RECENT EXPENSES",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const ExpensesScreen();
                      },
                    ));
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.view_agenda,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return const ExpenseBriefItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseBriefItem extends StatelessWidget {
  const ExpenseBriefItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Icon(Icons.credit_card),
            SizedBox(
              width: 10,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "25 EUR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " | ",
                  ),
                  TextSpan(
                    text: "25 October 2021",
                  ),
                  TextSpan(
                    text: " | ",
                  ),
                  TextSpan(
                    text: "16:30",
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.folder),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Utilities",
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.note),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Some note that is a bit longer for testing",
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeScreenPeriodBalances extends StatelessWidget {
  const _HomeScreenPeriodBalances({
    super.key,
    required this.color,
    required this.iconData,
  });

  final Color color;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "THIS WEEK",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      // Icons.calendar_view_week,
                      iconData,
                      // color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Accumulated Remainder",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "-4 EUR",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          // color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Spent",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      // Spacer(),
                      Text(
                        "-4 EUR",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          // color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remainder",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      // Spacer(),
                      Text(
                        "-4 EUR",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          // color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenTodayBalances extends StatelessWidget {
  const _HomeScreenTodayBalances({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "TODAY",
        //   style: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   "THIS WEEK",
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Text(
              "TODAY",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.calendar_view_day,
                  size: 36,
                  // iconData,
                  // color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        // Accumulated remainder
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Accumulated Remainder",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.info,
                  size: 16,
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "-11 EUR",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        // Other balances
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Spent",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.info,
                      size: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "7 EUR",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Remainder",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.info,
                      size: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "1 EUR",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeScreenTopButtons extends StatelessWidget {
  const _HomeScreenTopButtons({
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
                            child: const _HomeScreenEditDailyBudget(),
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
                      child: const _HomeScreenAddExpense(),
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

class _HomeScreenEditDailyBudget extends StatefulWidget {
  const _HomeScreenEditDailyBudget({super.key});

  @override
  State<_HomeScreenEditDailyBudget> createState() =>
      _HomeScreenEditDailyBudgetState();
}

class _HomeScreenEditDailyBudgetState
    extends State<_HomeScreenEditDailyBudget> {
  final TextEditingController _monthTextEditingController =
      TextEditingController();

  String _selectedCurrency = currencies.first;

  @override
  void dispose() {
    _monthTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EDIT DAILY BUDGET",
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
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            TextField(
              onTap: () async {
                final selectedMonth = await showDialog<SelectedMonth>(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        // height: 500,
                        // width: 200,
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //     color: Colors.grey.shade300,
                        //   ),
                        //   borderRadius: BorderRadius.circular(4),
                        // ),
                        color: Colors.white,
                        // padding: const EdgeInsets.all(15.0),
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 15,
                          left: 15,
                          right: 15,
                        ),
                        child: _HomeScreenMonthSelector(
                          onMonthSelection: (SelectedMonth? selectedMonth) {
                            return Navigator.pop(context, selectedMonth);
                          },
                        ),
                      ),
                    );
                  },
                );

                if (selectedMonth == null) return;

                _monthTextEditingController.text =
                    "${selectedMonth.monthName} - ${selectedMonth.year}";
              },
              controller: _monthTextEditingController,
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "MONTH",
                hintText: "Select month",
                suffixIcon: Icon(Icons.calendar_month),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Amount",
                      hintText: "Enter amount",
                      suffixIcon: Icon(Icons.credit_card),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 12, top: 0),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    // padding: const EdgeInsets.all(10),
                    decoration: const InputDecoration(
                      labelText: "Currency",
                      hintText: "Enter currency",
                      // suffixIcon: Icon(Icons.folder),
                    ),
                    value: _selectedCurrency,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCurrency = value!;
                      });
                    },
                    items: currencies
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.check_box,
                          size: 40,
                        ),
                        Text("Save"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.close,
                          size: 40,
                        ),
                        Text("Cancel"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // DropdownButtonFormField<String>(
            //   icon: const Padding(
            //     padding: EdgeInsets.only(right: 12, top: 0),
            //     child: Icon(Icons.folder),
            //   ),
            //   // padding: const EdgeInsets.all(10),
            //   decoration: const InputDecoration(
            //     labelText: "Category",
            //     hintText: "Enter category",
            //     // suffixIcon: Icon(Icons.folder),
            //   ),
            //   value: _selectedCategory,
            //   onChanged: (String? value) {
            //     setState(() {
            //       _selectedCategory = value!;
            //     });
            //   },
            //   items: categories
            //       .map(
            //         (e) => DropdownMenuItem(
            //           value: e,
            //           child: Text(e),
            //         ),
            //       )
            //       .toList(),
            // ),
          ],
        ),
      ],
    );
  }
}

class _HomeScreenMonthSelector extends StatefulWidget {
  const _HomeScreenMonthSelector({
    super.key,
    required this.onMonthSelection,
  });

  final void Function(SelectedMonth? selectedMonth) onMonthSelection;

  @override
  State<_HomeScreenMonthSelector> createState() =>
      _HomeScreenMonthSelectorState();
}

class _HomeScreenMonthSelectorState extends State<_HomeScreenMonthSelector> {
  int currentSelectedYear = DateTime.now().year;
  int currentPrevYear = DateTime.now().year - 1;
  int currentNextYear = DateTime.now().year + 1;

  SelectedMonth? _selectedMonth;

  @override
  Widget build(BuildContext context) {
    // SIZEDBOX around if any issues
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SELECT MONTH",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(
            //   width: 20,
            // ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentPrevYear--;
                  currentSelectedYear--;
                  currentNextYear--;
                });
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 20,
              ),
            ),
            Text(
              currentPrevYear.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              currentSelectedYear.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              currentNextYear.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPrevYear++;
                  currentSelectedYear++;
                  currentNextYear++;
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          // height: 500,
          // fit: FlexFit.tight,
          // height: 400,
          child: GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 0,
            crossAxisCount: 3,
            childAspectRatio: 2.0,
            children: List.generate(12, (index) {
              final month = index + 1;

              // TODO old implementation start
              // final monthDate = DateTime(currentSelectedYear, month, 1);

              // // need first moment of the month
              // final firstMillisecondOfTheMonth =
              //     monthDate.millisecondsSinceEpoch;

              // // need last moment of the month
              // // first find first millisecond of the next month
              // final firstMillisecondOfTheNextMonth = DateTime(
              //   currentSelectedYear,
              //   month + 1,
              //   1,
              // ).millisecondsSinceEpoch;

              // // then subtract 1 millisecond
              // final lastMillisecondOfTheMonth =
              //     firstMillisecondOfTheNextMonth - 1;

              // // ok, now lets get the name of this month
              // final monthName = DateFormat(DateFormat.MONTH).format(monthDate);
              // final selectedMonth = SelectedMonth(
              //   year: currentSelectedYear,
              //   month: month,
              //   monthName: monthName,
              //   firstMillisecondOfTheMonth: firstMillisecondOfTheMonth,
              //   lastMillisecondOfTheMonth: lastMillisecondOfTheMonth,
              // );
              // TODO old implementation end

              final monthMoments =
                  PeriodExtremesMomentsCalculator.calculateMonthMoments(
                      monthIndex: month, year: currentSelectedYear);

              final selectedMonth = SelectedMonth(
                firstMillisecondOfTheMonth:
                    monthMoments.periodStart.millisecondsSinceEpoch,
                lastMillisecondOfTheMonth:
                    monthMoments.periodEnd.millisecondsSinceEpoch,
                month: monthMoments.periodIndex,
                monthName: monthMoments.periodName,
                year: monthMoments.year,
              );

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMonth = selectedMonth;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedMonth == selectedMonth
                          ? Colors.blue
                          : Colors.grey.shade200,
                      // : null,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        // monthName.toUpperCase(),
                        selectedMonth.monthName.toUpperCase(),
                        style: TextStyle(
                          color: _selectedMonth == selectedMonth
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                  widget.onMonthSelection(_selectedMonth);
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.check_box,
                      size: 40,
                    ),
                    Text("Save"),
                  ],
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                  widget.onMonthSelection(null);
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.close,
                      size: 40,
                    ),
                    Text("Cancel"),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

class _HomeScreenAddExpense extends StatefulWidget {
  const _HomeScreenAddExpense({
    super.key,
  });

  @override
  State<_HomeScreenAddExpense> createState() => _HomeScreenAddExpenseState();
}

class _HomeScreenAddExpenseState extends State<_HomeScreenAddExpense> {
  String _selectedCategory = categories.first;

  // TODO temp

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // TODO this should be extracted as it is exverywhere, and reused
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ADD EXPENSE",
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
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Enter amount",
                suffixIcon: Icon(Icons.credit_card),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Date",
                      hintText: "Enter date",
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Time",
                      hintText: "Enter time",
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              icon: const Padding(
                padding: EdgeInsets.only(right: 12, top: 0),
                // child: Icon(Icons.folder),
                child: Icon(Icons.arrow_drop_down),
              ),
              // padding: const EdgeInsets.all(10),
              decoration: const InputDecoration(
                labelText: "Category",
                hintText: "Enter category",
                // suffixIcon: Icon(Icons.folder),
              ),
              value: _selectedCategory,
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              items: categories
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Note",
                hintText: "Enter note",
                // suffixIcon: Icon(Icons.note),
                suffixIcon: Icon(Icons.note),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.check_box,
                      size: 40,
                    ),
                    Text("Save"),
                  ],
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.close,
                      size: 40,
                    ),
                    Text("Cancel"),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

const List<String> categories = [
  "Utilities",
  "Groceries",
  "Transport",
  "Entertainment",
  "Health",
  "Other",
];

const List<String> currencies = [
  "EUR",
];

// class TempMonthSelectorWidget extends StatefulWidget {
//   const TempMonthSelectorWidget({super.key});

//   @override
//   State<TempMonthSelectorWidget> createState() =>
//       _TempMonthSelectorWidgetState();
// }

// class _TempMonthSelectorWidgetState extends State<TempMonthSelectorWidget> {
//   int currentSelectedYear = DateTime.now().year;
//   int currentPrevYear = DateTime.now().year - 1;
//   int currentNextYear = DateTime.now().year + 1;

//   SelectedMonth? _selectedMonth;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Edit daily budget",
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         currentPrevYear--;
//                         currentSelectedYear--;
//                         currentNextYear--;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.grey,
//                       size: 20,
//                     ),
//                   ),
//                   Text(
//                     currentPrevYear.toString(),
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 24,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     currentSelectedYear.toString(),
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     currentNextYear.toString(),
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 24,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         currentPrevYear++;
//                         currentSelectedYear++;
//                         currentNextYear++;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.grey,
//                       size: 20,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 // height: 400,
//                 child: GridView.count(
//                   mainAxisSpacing: 0,
//                   crossAxisCount: 3,
//                   childAspectRatio: 2.0,
//                   children: List.generate(12, (index) {
//                     final month = index + 1;

//                     final monthDate = DateTime(currentSelectedYear, month, 1);

//                     // need first moment of the month
//                     final firstMillisecondOfTheMonth =
//                         monthDate.millisecondsSinceEpoch;

//                     // need last moment of the month
//                     // first find first millisecond of the next month
//                     final firstMillisecondOfTheNextMonth = DateTime(
//                       currentSelectedYear,
//                       month + 1,
//                       1,
//                     ).millisecondsSinceEpoch;

//                     // then subtract 1 millisecond
//                     final lastMillisecondOfTheMonth =
//                         firstMillisecondOfTheNextMonth - 1;

//                     // ok, now lets get the name of this month
//                     final monthName =
//                         DateFormat(DateFormat.MONTH).format(monthDate);

//                     final selectedMonth = SelectedMonth(
//                       year: currentSelectedYear,
//                       month: month,
//                       monthName: monthName,
//                       firstMillisecondOfTheMonth: firstMillisecondOfTheMonth,
//                       lastMillisecondOfTheMonth: lastMillisecondOfTheMonth,
//                     );

//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedMonth = selectedMonth;
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: _selectedMonth == selectedMonth
//                                 ? Colors.blue
//                                 : Colors.grey.shade200,
//                             // : null,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Center(
//                             child: Text(
//                               monthName.toUpperCase(),
//                               style: TextStyle(
//                                 color: _selectedMonth == selectedMonth
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Column(
//                         children: [
//                           Icon(
//                             Icons.check_box,
//                             size: 40,
//                           ),
//                           Text("Save"),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 40,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Column(
//                         children: [
//                           Icon(
//                             Icons.close,
//                             size: 40,
//                           ),
//                           Text("Cancel"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SelectedMonth extends Equatable {
  const SelectedMonth({
    required this.year,
    required this.month,
    required this.monthName,
    required this.firstMillisecondOfTheMonth,
    required this.lastMillisecondOfTheMonth,
  });

  final int year;
  final int month;
  final String monthName;
  final int firstMillisecondOfTheMonth;
  final int lastMillisecondOfTheMonth;

  @override
  List<Object> get props => [
        year,
        month,
        firstMillisecondOfTheMonth,
        lastMillisecondOfTheMonth,
      ];
}
