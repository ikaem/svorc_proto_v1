// TODO remove this new eventually
import 'dart:developer';
import 'dart:math' hide log;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/dialog_wrapper.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/get_existing_month_daily_budgets/get_existing_month_daily_budgets_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/get_month_daily_budget/get_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/controllers/update_month_daily_budget/update_month_daily_budget_controller.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/presentation/widgets/existing_month_daily_budgets_selector.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

class EditMonthDailyBudgetNew extends ConsumerStatefulWidget {
  const EditMonthDailyBudgetNew({
    super.key,
    // required this.onCancelEdit,
    // required this.onSaveEdit,
    required this.onClose,
    required this.currentMonthDailyBudget,
  });

  // final VoidCallback onCancelEdit;
  // final VoidCallback onSaveEdit;
  final VoidCallback onClose;
  final PeriodDailyBudgetModel currentMonthDailyBudget;

  @override
  ConsumerState<EditMonthDailyBudgetNew> createState() =>
      _EditMonthDailyBudgetNewState();
}

class _EditMonthDailyBudgetNewState
    extends ConsumerState<EditMonthDailyBudgetNew> {
// TODO remo

  late PeriodDailyBudgetModel _selectedBudget;

  late TextEditingController _amountTextEditingController;
  late TextEditingController _monthTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // TODO move to separate method
    _selectedBudget = widget.currentMonthDailyBudget;
    _amountTextEditingController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.currentMonthDailyBudget.amount.toString(),
      ),
    );

    _monthTextEditingController = TextEditingController.fromValue(
      TextEditingValue(
        // text: widget.currentMonthDailyBudget.periodStart.toString(),
        text: _getDateFormattedMonthName(
            widget.currentMonthDailyBudget.periodStart),
      ),
    );

    // TODO test
    ref.listenManual(
      updateMonthDailyBudgetControllerProvider,
      (_, currentState) {
        currentState.when(
          data: (data) {
            if (data == null) {
              log("message: data is null: $data");
              return;
            }

            log("message: data is not null: $data");

            widget.onClose();

            // TODO maybe here we can call get current month budget or something
            // TODO this does not work
            // ref.read(getMonthDailyBudgetControllerProvider(DateTime.now()));
          },
          error: (error, stackTrace) {
            log("message: error: $error");
          },
          loading: () {
            log("message: loading");
          },
        );
      },
      fireImmediately: true,
    );
  }

  @override
  Widget build(
    BuildContext context,
    // WidgetRef ref,
  ) {
    // TODO this late will have to be used to:
    // - get current month budget
    // - set state of text editing controller

    // ref.listen();

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
        Builder(builder: (context) {
          final AsyncValue<GetExistingMonthDailyBudgetsControllerStateData>
              state = ref.watch(getExistingMonthDailyBudgetsControllerProvider);

          return state.when(
            data: (data) {
              final List<PeriodDailyBudgetModel> budgets =
                  data.existingMonthDailyBudgets;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onTap: () async {
                      final PeriodDailyBudgetModel? selectedBudget =
                          await showDialog<PeriodDailyBudgetModel>(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return DialogWrapper(
                            child: ExistingMonthDailyBudgetsSelector(
                              existingMonthDailyBudgets: budgets,
                              onCancelSelect: () {
                                Navigator.of(context).pop();
                              },
                              onSelect:
                                  (PeriodDailyBudgetModel selectedBudget) {
                                Navigator.of(context).pop(selectedBudget);
                              },
                            ),
                          );
                        },
                      );

                      if (selectedBudget == null) return;

                      final String formattedMonthName =
                          _getDateFormattedMonthName(
                              selectedBudget.periodStart);

                      final value = selectedBudget.amount.toString();

                      setState(() {
                        _selectedBudget = selectedBudget;
                        _amountTextEditingController.text = value;
                        _monthTextEditingController.text = formattedMonthName;
                      });
                    },
                    controller: _monthTextEditingController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "MONTH",
                      hintText: "Select month",
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                  // TODO temp only for now
                  // TextButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       // TODO temp
                  //       barrierDismissible: false,
                  //       context: context,
                  //       builder: (context) {
                  //         return DialogWrapper(
                  //           child: ExistingMonthDailyBudgetsSelector(
                  //             existingMonthDailyBudgets: budgets,
                  //             onCancelSelect: () {
                  //               Navigator.of(context).pop();
                  //             },
                  //             onSelect:
                  //                 (PeriodDailyBudgetModel selectedBudget) {
                  //               Navigator.of(context).pop();
                  //             },
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: const Text("Open daily budgets selector temp"),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextField(
                    controller: _amountTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "AMOUNT",
                      hintText: "Enter amount",
                      suffixIcon: Icon(Icons.credit_card),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // children: [GestureDetector()],
                      children: [
                        GestureDetector(
                          onTap: () {
                            // TODO this will use the controlkler
                            // and then we will have i guess .listenManual or .listen on controlelr provider to edit the budget

                            final valueString =
                                _amountTextEditingController.text;
                            final value = int.tryParse(valueString);

                            if (value == null) {
                              // TODO this is not even visible because of keyboard
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Invalid amount"),
                                ),
                              );
                              return;
                            }

                            ref
                                .read(updateMonthDailyBudgetControllerProvider
                                    .notifier)
                                .onUpdateBudget(
                                  // amount: Random().nextInt(1000),
                                  amount: value,
                                  id: _selectedBudget.id,
                                );
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
                          onTap: widget.onClose,
                          child: const Column(
                            children: [
                              Icon(
                                Icons.close,
                                size: 40,
                              ),
                              Text("Save"),
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
            },
            error: (error, stackTrace) {
              return const Center(
                child: Text("Error loading existing month daily budgets"),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }),

        // --------------------
        // const Center(
        //   child: Text("Hello new edit budget widget"),
        // ),
        // TextButton(
        //   onPressed: () {
        //     showDialog(
        //       barrierDismissible: false,
        //       context: context,
        //       builder: (context) {
        //         // TODO temp only
        //         // final existingBudgets =
        //         //     _getTempExistingMonthDailyBudgetsValue();

        //         final tempBudgets = _getTempExistingMonthDailyBudgets();

        //         return DialogWrapper(
        //           child: ExistingMonthDailyBudgetsSelector(
        //             // existingMonthDailyBudgetsValue: existingBudgets,
        //             existingMonthDailyBudgets: tempBudgets,
        //             onCancelSelect: () {
        //               Navigator.of(context).pop();
        //             },
        //             onSelect: (PeriodDailyBudgetModel selectedBudget) {
        //               Navigator.of(context).pop();
        //             },
        //           ),
        //         );
        //       },
        //     );
        //   },
        //   child: const Text("Open daily budgets selector temp"),
        // ),
        // // TODO temp
        // Row(
        //   children: [
        //     TextButton(
        //       onPressed: onCancelEdit,
        //       child: const Text("Cancel"),
        //     ),
        //     TextButton(
        //       onPressed: onSaveEdit,
        //       child: const Text("Save"),
        //     ),
        //   ],
        // )
      ],
    );
  }

  // TODO move below
  String _getDateFormattedMonthName(DateTime date) {
    final String formattedDate = DateFormat("MMMM yyyy").format(date);
    // final String formattedDate = DateFormat().format(date);

    return formattedDate;
  }
}

// TODO move this to values

// TODO maybe this should be returned by the controller
class ExistingMonthDailyBudgetsValue extends Equatable {
  const ExistingMonthDailyBudgetsValue({
    required List<PeriodDailyBudgetModel> budgets,
  }) : _budgets = budgets;

  final List<PeriodDailyBudgetModel> _budgets;

  List<int> get years =>
      _budgets.map((e) => e.periodStart.year).toSet().toList()..sort();

  List<PeriodDailyBudgetModel> getBudgetsForYear(int year) {
    return _budgets
        .where((element) => element.periodStart.year == year)
        .toList();
    // TODO this will need to be sorted
    // ..sort();
  }

  PeriodDailyBudgetModel get thisMonthBudget {
    final now = DateTime.now();
    final PeriodExtremesMoments extremes =
        PeriodExtremesMomentsCalculator.calculateMonthMoments(
            monthIndex: now.month, year: now.year);

    final budget =
        _budgets.firstWhere((b) => b.periodStart == extremes.periodStart);

    return budget;
  }

  @override
  List<Object?> get props => [_budgets];
}
