import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BalanceReportScreen extends StatefulWidget {
  const BalanceReportScreen({super.key});

  @override
  State<BalanceReportScreen> createState() => _BalanceReportScreenState();
}

class _BalanceReportScreenState extends State<BalanceReportScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dailyExpenses = List.generate(
      31,
      (index) {
        return SpentReportDaily(
          date: "${index + 1} Oct 2024",
          // expensesAmount: (Random().nextInt(100) - 50) * 100,
          spentValue: (Random().nextInt(50)) * 100,
        );
      },
    );

    final monthlyReport = BalanceReportMonthly(
      spentDailyReports: dailyExpenses,
      dailyBudget: 600,
      monthName: "October",
      daysNumber: 31,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance Report'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Month selector
            const _BalanceReportScreenMonthSelector(),
            const SizedBox(height: 10),
            // // Report summary
            // const Flexible(child: Text("hello")),
            // const Text("hello"),
            // Flexible(
            //   fit: FlexFit.loose,
            //   // height: 400,
            //   child: _BalanceReportScreenSummary(
            //     dailyBudget: monthlyReport.dailyBudget,
            //     remainder: monthlyReport.remainder,
            //     totalSpent: monthlyReport.totalSpent,
            //   ),
            // ),
            // SizedBox(
            //   // fit: FlexFit.loose,
            //   height: 200,
            //   // height: 400,
            //   child: _BalanceReportScreenSummary(
            //     dailyBudget: monthlyReport.dailyBudget,
            //     remainder: monthlyReport.remainder,
            //     totalSpent: monthlyReport.totalSpent,
            //     monthlyBudget: monthlyReport.monthlyBudget,
            //   ),
            // ),

            ConstrainedBox(
              constraints: const BoxConstraints(
                // minHeight: 50,
                maxHeight: 400,
              ),

              // fit: FlexFit.loose,
              // height: 200,
              // height: 400,
              child: _BalanceReportScreenSummary(
                dailyBudget: monthlyReport.dailyBudget,
                remainder: monthlyReport.remainder,
                totalSpent: monthlyReport.totalSpent,
                monthlyBudget: monthlyReport.monthlyBudget,
              ),
            ),
            const SizedBox(height: 20),
            // Report actual
            Material(
              color: Colors.grey.shade300,
              child: TabBar(
                // isScrollable: true,
                // padding: const EdgeInsets.all(0),
                // overlayColor: WidgetStateProperty.all(Colors.red),
                controller: _tabController,
                indicator: const BoxDecoration(
                  // color: Colors.blue,
                  border: Border.fromBorderSide(BorderSide.none),
                ),
                // indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                dividerHeight: 0,
                labelPadding: const EdgeInsets.all(0),
                // indicatorPadding: const EdgeInsets.all(5),
                tabs: const [
                  Tab(
                    // text: "SPENT",
                    child: Text("SPENT"),
                  ),
                  Tab(
                    text: "REMAINDER",
                  ),
                  Tab(
                    text: "ACCUMULATION",
                    // child: SizedBox(
                    //   width: 20,
                    //   child: Text("ACCUMULATED REMAINDER"),
                    // ),
                  ),
                ],
              ),
            ),
            Expanded(
              // flex: 2,
              // fit: FlexFit.tight,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // SPENT
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.grey.shade100,
                    // color: Colors.yellow,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final value =
                            monthlyReport.spentDailyReports[index].spentValue;

                        return _BalanceReportGraphItem(
                          value: value,
                          largestAbsoluteValue:
                              monthlyReport.dailyLargestAbsoluteSpentValue,
                          date: monthlyReport.spentDailyReports[index].date,
                          tresholdValue: monthlyReport.dailyBudget,
                          isAboveTresholdBad: true,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: monthlyReport.spentDailyReports.length,
                    ),
                  ),
                  // REMAINDER
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.grey.shade100,
                    // color: Colors.yellow,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        // final value =
                        //     monthlyReport.dailyReports[index].expensesAmount;

                        // final value = monthlyReport.dailyReports[index]
                        //     .getDailyRemainder(monthlyReport.dailyBudget);

                        // const value = 6;

                        final value = monthlyReport
                            .dailyRemainderReports[index].remainder;

                        return _BalanceReportGraphItem(
                          value: value,
                          largestAbsoluteValue:
                              monthlyReport.dailyLargestAbsoluteRemainderValue,
                          // date: monthlyReport.spentDailyReports[index].date,
                          date: monthlyReport.dailyRemainderReports[index].date,
                          // tresholdValue: monthlyReport.dailyBudget,
                          tresholdValue: 0,
                          isAboveTresholdBad: false,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: monthlyReport.dailyRemainderReports.length,
                    ),
                  ),
                  // ACCUMULATION
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.grey.shade100,
                    // color: Colors.yellow,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        // final value =
                        //     monthlyReport.dailyReports[index].expensesAmount;

                        // final value = monthlyReport.dailyReports[index]
                        //     .getDailyRemainder(monthlyReport.dailyBudget);

                        // const value = 6;

                        final value = monthlyReport
                            .dailyRemainderReports[index].accumulatedRemainder;

                        return _BalanceReportGraphItem(
                          value: value,
                          largestAbsoluteValue: monthlyReport
                              .dailyLargestAbsoluteAccumulatedRemainderValue,
                          // date: monthlyReport.spentDailyReports[index].date,
                          date: monthlyReport.dailyRemainderReports[index].date,
                          // tresholdValue: monthlyReport.dailyBudget,
                          tresholdValue: 0,
                          isAboveTresholdBad: false,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: monthlyReport.dailyRemainderReports.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceReportGraphItem extends StatelessWidget {
  const _BalanceReportGraphItem({
    super.key,
    required this.value,
    required this.largestAbsoluteValue,
    required this.date,
    required this.tresholdValue,
    required this.isAboveTresholdBad,
  });

  final int value;
  final int largestAbsoluteValue;
  final String date;
  final int tresholdValue;
  final bool isAboveTresholdBad;

  // get widget sizes
  // https://www.dhiwise.com/post/getting-the-right-size-a-tutorial-on-flutter-get-widget-size

  Color get color {
    if (value > tresholdValue) {
      if (isAboveTresholdBad) {
        return Colors.red;
      }
      return Colors.green;
    }

    if (value < tresholdValue) {
      if (isAboveTresholdBad) {
        return Colors.green;
      }
      return Colors.red;
    }

    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(date),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LayoutBuilder(builder: (context, constraints) {
              final sizedBoxWidth =
                  constraints.maxWidth / (largestAbsoluteValue / 100);

              final percentage = value.abs() / 100;

              final width = sizedBoxWidth * percentage;

              return SizedBox(
                height: 25,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // background
                    Row(
                      children: [
                        Container(
                          // width: 17,
                          width: width,
                          // color: Colors.yellow,
                          color: color,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.blueGrey,
                            // child: const Text(
                            //   "100 EUR",
                            //   overflow: TextOverflow.visible,
                            // ),
                          ),
                        ),
                      ],
                    ),
                    // foreground
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${value.toString().toMajorFromCent()} EUR",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _BalanceReportScreenMonthSelector extends StatelessWidget {
  const _BalanceReportScreenMonthSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        // onTap: () async {
        //   final selectedMonth = await showDialog<SelectedMonth>(
        //     context: context,
        //     builder: (context) {
        //       return Dialog(
        //         insetPadding: const EdgeInsets.all(15),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(4),
        //         ),
        //         child: Container(
        //           // height: 500,
        //           // width: 200,
        //           // decoration: BoxDecoration(
        //           //   border: Border.all(
        //           //     color: Colors.grey.shade300,
        //           //   ),
        //           //   borderRadius: BorderRadius.circular(4),
        //           // ),
        //           color: Colors.white,
        //           // padding: const EdgeInsets.all(15.0),
        //           padding: EdgeInsets.only(
        //             bottom: MediaQuery.of(context).viewInsets.bottom,
        //             top: 15,
        //             left: 15,
        //             right: 15,
        //           ),
        //           child: _HomeScreenMonthSelector(
        //             onMonthSelection: (SelectedMonth? selectedMonth) {
        //               return Navigator.pop(context, selectedMonth);
        //             },
        //           ),
        //         ),
        //       );
        //     },
        //   );

        //   if (selectedMonth == null) return;

        //   _monthTextEditingController.text =
        //       "${selectedMonth.monthName} - ${selectedMonth.year}";
        // },
        // controller: _monthTextEditingController,
        readOnly: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "MONTH",
          hintText: "Select month",
          suffixIcon: Icon(Icons.calendar_month),
        ),
      ),
    );
  }
}

class _BalanceReportScreenSummary extends StatelessWidget {
  const _BalanceReportScreenSummary({
    super.key,
    required this.dailyBudget,
    required this.monthlyBudget,
    required this.totalSpent,
    required this.remainder,
  });

  final int dailyBudget;
  final int monthlyBudget;
  final int totalSpent;
  final int remainder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ColoredBox(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Daily Budget",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${dailyBudget.toString().toMajorFromCent()} EUR",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ColoredBox(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Monthly Budget",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${monthlyBudget.toString().toMajorFromCent()} EUR",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ColoredBox(
              color: Colors.grey.shade400,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Spent",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            // "${dailyBudget.toString().toMajorFromCent()} EUR",
                            // "2000 EUR",
                            "${totalSpent.toString().toMajorFromCent()} EUR",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Remainder",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            // "${dailyBudget.toString().toMajorFromCent()} EUR",
                            // "20000000000000000000000000000000000000000000000000 EUR",
                            // "200 EUR",
                            // "200000000000000000 EUR",
                            "${remainder.toString().toMajorFromCent()} EUR",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     height: 130,
  //     child: Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           Expanded(
  //             flex: 2,
  //             child: Container(
  //               padding: const EdgeInsets.all(10),
  //               color: Colors.grey,
  //               width: 100,
  //               child: Column(
  //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Daily Budget",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(
  //                     "${dailyBudget.toString().toMajorFromCent()} EUR",
  //                     style: const TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             flex: 3,
  //             child: Container(
  //               color: Colors.grey,
  //               padding: const EdgeInsets.all(10),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const Text(
  //                           "Spent",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           "${totalSpent.toString().toMajorFromCent()} EUR",
  //                           style: const TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         const Text(
  //                           "Remainder",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           "${remainder.toString().toMajorFromCent()} EUR",
  //                           style: const TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// TODO temp

class BalanceReportMonthly {
  const BalanceReportMonthly({
    required this.spentDailyReports,
    required this.dailyBudget,
    required this.monthName,
    required this.daysNumber,
  });

  final int daysNumber;
  final int dailyBudget;
  final String monthName;
  final List<SpentReportDaily> spentDailyReports;

  int get totalSpent => spentDailyReports.fold(
        0,
        (previousValue, element) => previousValue + element.spentValue,
      );

  int get dailyLargestAbsoluteSpentValue {
    final largest = spentDailyReports.fold(
      0,
      (previousValue, element) =>
          max(previousValue.abs(), element.spentValue.abs()),
    );

    return largest;
  }

  int get dailyLargestAbsoluteRemainderValue {
    final largest = dailyRemainderReports.fold(
      0,
      (prev, current) {
        return max(prev.abs(), current.remainder.abs());
      },
    );

    return largest;
  }

  int get dailyLargestAbsoluteAccumulatedRemainderValue {
    final largest = dailyRemainderReports.fold(
      0,
      (prev, current) {
        return max(prev.abs(), current.accumulatedRemainder.abs());
      },
    );

    return largest;
  }

  int get monthlyBudget => dailyBudget * daysNumber;
  int get remainder => monthlyBudget - totalSpent;

  List<RemainderReportDaily2> get dailyRemainderReports {
    final dailyRemainderReports = <RemainderReportDaily2>[];

    // we will go through the list and just pass data

    for (int i = 0; i < spentDailyReports.length; i++) {
      final spendDailyReport = spentDailyReports[i];

      // assuming index 0 is the first day of the month
      // so this expects list sorted by date
      if (i == 0) {
        final remainderDailyReport = RemainderReportDaily2(
          date: spendDailyReport.date,
          dailyBudget: dailyBudget,
          spentValue: spendDailyReport.spentValue,
          previousDateAccumulatedRemainder: 0,
        );

        dailyRemainderReports.add(remainderDailyReport);
      } else {
        final remainderDailyReport = RemainderReportDaily2(
          date: spendDailyReport.date,
          dailyBudget: dailyBudget,
          spentValue: spendDailyReport.spentValue,
          previousDateAccumulatedRemainder:
              dailyRemainderReports[i - 1].accumulatedRemainder,
        );

        dailyRemainderReports.add(remainderDailyReport);
      }

      // TODO this is assuming that the first day of the month has index 0
      // final previousDateAccumulatedRemainder =
      //     i == 0 ? 0 : dailyRemainderReports[i - 1].accumulatedRemainder;

      // final remainderDailyReport = RemainderReportDaily2(
      //   date: spendDailyReport.date,
      //   dailyBudget: dailyBudget,
      //   spentValue: spendDailyReport.spentValue,
      //   previousDateAccumulatedRemainder: previousDateAccumulatedRemainder,
      // );
    }

    return dailyRemainderReports;
  }

  // List<int>
}

class SpentReportDaily {
  const SpentReportDaily({
    required this.date,
    required this.spentValue,
  });

  final String date;
  final int spentValue;

  // int getDailyRemainder(int dailyBudget) {
  //   return dailyBudget - expensesAmount;
  // }

  // int getDailyAccumulatedRemainder(
  //   int dailyBudget,
  //   // TODO if first day of the month, this should be 0
  //   int previousAccumulatedRemainder,
  // ) {
  //   final todayRemainder = getDailyRemainder(dailyBudget);

  //   final todayAccumulatedRemainder =
  //       todayRemainder + previousAccumulatedRemainder;
  //   return todayAccumulatedRemainder;
  // }
}

class RemainderReportDaily {
  const RemainderReportDaily({
    required this.date,
    required this.dailyBudget,
    required this.spentValue,
  });

  final String date;
  // final int remainder;
  final int dailyBudget;
  final int spentValue;

  int getRemainder() {
    return dailyBudget - spentValue;
  }
}

class AccumulatedRemainderReportDaily {
  const AccumulatedRemainderReportDaily({
    required this.date,
    required this.dailyBudget,
    required this.spentValue,
    required this.previousDateAccumulatedRemainder,
  });

  final String date;
  final int dailyBudget;
  final int spentValue;
  final int previousDateAccumulatedRemainder;

  int getAccumulatedRemainder() {
    final todayRemainder = dailyBudget - spentValue;
    final todayAccumulatedRemainder =
        todayRemainder + previousDateAccumulatedRemainder;

    return todayAccumulatedRemainder;
  }
}

class RemainderReportDaily2 {
  const RemainderReportDaily2({
    required this.date,
    required this.dailyBudget,
    required this.spentValue,
    required this.previousDateAccumulatedRemainder,
  });

  final String date;
  final int dailyBudget;
  final int spentValue;
  final int previousDateAccumulatedRemainder;

  int get remainder {
    return dailyBudget - spentValue;
  }

  int get accumulatedRemainder {
    final todayRemainder = dailyBudget - spentValue;
    final todayAccumulatedRemainder =
        todayRemainder + previousDateAccumulatedRemainder;

    return todayAccumulatedRemainder;
  }
}

// TODO move to utils

extension StringExtensions on String {
  String toMajorFromCent() {
    final value = int.parse(this);

    final major = value / 100;

    return major.toStringAsFixed(2);
  }
}
