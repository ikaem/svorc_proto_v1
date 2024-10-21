import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/bloc/cubits/get_recent_expenses/get_recent_expenses_cubit.dart';
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
