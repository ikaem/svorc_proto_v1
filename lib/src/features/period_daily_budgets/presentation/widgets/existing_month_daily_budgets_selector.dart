import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/set_month_daily_budget/set_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/presentation/widgets/edit_month_daily_budget_new.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

// TODO create controller for this that will keep state

// TODO maybe this can be a stateless widget - we will see
class ExistingMonthDailyBudgetsSelector extends ConsumerWidget {
  ExistingMonthDailyBudgetsSelector({
    super.key,
    // required this.budgets,
    // required this.existingMonthDailyBudgetsValue,
    required this.existingMonthDailyBudgets,
    required this.onCancelSelect,
    required this.onSelect,
  });

  // final ExistingMonthDailyBudgetsValue existingMonthDailyBudgetsValue;
  final List<PeriodDailyBudgetModel> existingMonthDailyBudgets;
  final VoidCallback onCancelSelect;
  // TODO this will initially need to send selected bugdet to the edit widget
  final Function(PeriodDailyBudgetModel) onSelect;

  // TODO there is a bug here - if we
  // late PeriodDailyBudgetModel _selectedBudget =
  late final SetMonthDailyBudgetControllerProvider
      _monthDailyBudgetsSelectorControllerProviderInstance =
      setMonthDailyBudgetControllerProvider(existingMonthDailyBudgets);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(_monthDailyBudgetsSelectorControllerProviderInstance);

    return switch (state) {
      // TODO: Handle this case.
      SetMonthDailyBudgetControllerStateDataNoBudgetsProvided() => const Center(
          child: Text("No budgets provided"),
        ),
      // TODO: Handle this case.
      // SetMonthDailyBudgetControllerStateDataSelections() => Column(
      // NOTE: both od these are legit
      SetMonthDailyBudgetControllerStateDataSelections selectionsState =>
        Column(
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  // onPressed: _onSetPrevYear,
                  onPressed: ref
                      .read(_monthDailyBudgetsSelectorControllerProviderInstance
                          .notifier)
                      .onSetPrevYear,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          // widget.existingMonthDailyBudgetsValue.years.map((year) {
                          state.years.map((year) {
                        final isCurrentYearSelected =
                            year == state.selectedYear;
                        return GestureDetector(
                          // onTap: () {
                          //   // setState(() {
                          //   //   _selectedYear = year;
                          //   // });
                          // },
                          onTap: () {
                            ref
                                .read(
                                    _monthDailyBudgetsSelectorControllerProviderInstance
                                        .notifier)
                                .onSetYear(year);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              year.toString(),
                              style: TextStyle(
                                fontWeight: isCurrentYearSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                IconButton(
                  // onPressed: _onSetNextYear,
                  onPressed: ref
                      .read(_monthDailyBudgetsSelectorControllerProviderInstance
                          .notifier)
                      .onSetNextYear,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Builder(builder: (context) {
              // final items = widget.existingMonthDailyBudgetsValue
              //     .getBudgetsForYear(_selectedYear);

              final items = state.selectedYearBudgets;

              return SizedBox(
                height: 250,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    final monthMoments =
                        PeriodExtremesMomentsCalculator.calculateMonthMoments(
                      monthIndex: item.periodStart.month,
                      year: item.periodStart.year,
                    );
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(
                                _monthDailyBudgetsSelectorControllerProviderInstance
                                    .notifier)
                            .onSetBudget(item);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              // color: Colors.grey.shade200,
                              color: state.selectedBudget == item
                                  ? Colors.blue
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              monthMoments.periodName,
                              style: TextStyle(
                                color: state.selectedBudget == item
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      onSelect(state.selectedBudget);
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
                      // widget.onMonthSelection(null);
                      onCancelSelect();
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
        )
    };

    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     const Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           "SELECT MONTH",
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         IconButton(
    //           // onPressed: _onSetPrevYear,
    //           onPressed: ref
    //               .read(_monthDailyBudgetsSelectorControllerProviderInstance
    //                   .notifier)
    //               .onSetPrevYear,
    //           icon: const Icon(
    //             Icons.arrow_back_ios,
    //             color: Colors.grey,
    //             size: 20,
    //           ),
    //         ),
    //         Center(
    //           child: SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child: Row(
    //               children:
    //                   // widget.existingMonthDailyBudgetsValue.years.map((year) {
    //                   state.years.map((year) {
    //                 final isCurrentYearSelected = year == state.selectedYear;
    //                 return GestureDetector(
    //                   // onTap: () {
    //                   //   // setState(() {
    //                   //   //   _selectedYear = year;
    //                   //   // });
    //                   // },
    //                   onTap: () {
    //                     ref
    //                         .read(
    //                             _monthDailyBudgetsSelectorControllerProviderInstance
    //                                 .notifier)
    //                         .onSetYear(year);
    //                   },
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Text(
    //                       year.toString(),
    //                       style: TextStyle(
    //                         fontWeight: isCurrentYearSelected
    //                             ? FontWeight.bold
    //                             : FontWeight.normal,
    //                         fontSize: 24,
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }).toList(),
    //             ),
    //           ),
    //         ),
    //         IconButton(
    //           // onPressed: _onSetNextYear,
    //           onPressed: ref
    //               .read(_monthDailyBudgetsSelectorControllerProviderInstance
    //                   .notifier)
    //               .onSetNextYear,
    //           icon: const Icon(
    //             Icons.arrow_forward_ios,
    //             color: Colors.grey,
    //             size: 20,
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     Builder(builder: (context) {
    //       // final items = widget.existingMonthDailyBudgetsValue
    //       //     .getBudgetsForYear(_selectedYear);

    //       final items = state.selectedYearBudgets;

    //       return SizedBox(
    //         height: 250,
    //         child: GridView.builder(
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 3,
    //             childAspectRatio: 2.0,
    //             mainAxisSpacing: 8,
    //             crossAxisSpacing: 8,
    //           ),
    //           itemCount: items.length,
    //           itemBuilder: (context, index) {
    //             final item = items[index];

    //             final monthMoments =
    //                 PeriodExtremesMomentsCalculator.calculateMonthMoments(
    //               monthIndex: item.periodStart.month,
    //               year: item.periodStart.year,
    //             );
    //             return GestureDetector(
    //               onTap: () {
    //                 ref
    //                     .read(
    //                         _monthDailyBudgetsSelectorControllerProviderInstance
    //                             .notifier)
    //                     .onSetBudget(item);
    //               },
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: DecoratedBox(
    //                   decoration: BoxDecoration(
    //                       // color: Colors.grey.shade200,
    //                       color: state.selectedBudget == item
    //                           ? Colors.blue
    //                           : Colors.grey.shade200,
    //                       borderRadius: BorderRadius.circular(4)),
    //                   child: Center(
    //                     child: Text(
    //                       monthMoments.periodName,
    //                       style: TextStyle(
    //                         color: state.selectedBudget == item
    //                             ? Colors.white
    //                             : Colors.black,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       );
    //     }),
    //     const SizedBox(
    //       height: 40,
    //     ),
    //     Center(
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               // Navigator.pop(context);
    //               // widget.onMonthSelection(_selectedMonth);
    //             },
    //             child: const Column(
    //               children: [
    //                 Icon(
    //                   Icons.check_box,
    //                   size: 40,
    //                 ),
    //                 Text("Save"),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 40,
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               // Navigator.pop(context);
    //               // widget.onMonthSelection(null);
    //             },
    //             child: const Column(
    //               children: [
    //                 Icon(
    //                   Icons.close,
    //                   size: 40,
    //                 ),
    //                 Text("Cancel"),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 40,
    //     ),
    //   ],
    // );
  }

  // TODO this will go into the controller
  // void _onSetNextYear() {
  //   // final years = widget.existingMonthDailyBudgetsValue.years;

  //   // // now get length of this
  //   // final yearsLength = years.length;

  //   // if (yearsLength == 0) return;
  //   // if (yearsLength == 1) return;

  //   // // now we know there are more than 1 item
  //   // // check if index of current year is bigger than lenght
  //   // final currentYearIndex = years.indexOf(_selectedYear);
  //   // if (currentYearIndex >= years.length - 1) return;

  //   // // now we know current year is not the last one
  //   // final nextYearIndex = currentYearIndex + 1;
  //   // final nextYear = years[nextYearIndex];

  //   // setState(() {
  //   //   _selectedYear = nextYear;
  //   // });
  // }

  // void _onSetPrevYear() {
  //   // final years = widget.existingMonthDailyBudgetsValue.years;

  //   // final currentYearIndex = years.indexOf(_selectedYear);

  //   // // if it is first element, return
  //   // if (currentYearIndex == 0) return;

  //   // // now it is not first element
  //   // final prevYearIndex = currentYearIndex - 1;
  //   // final prevYear = years[prevYearIndex];

  //   // setState(() {
  //   //   _selectedYear = prevYear;
  //   // });
  // }
}

// how should we make selector of years
// selector should only show ear selections for those year that exist in the map i guess

// and then each year should have a list of months

// can we make a model for it

// model should be called existing budgets year yelections
