import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/create_expense/create_expense_controller.dart';

class AddMonthDailyBudget extends ConsumerStatefulWidget {
  const AddMonthDailyBudget({
    super.key,
    required this.onSuccess,
  });

  final VoidCallback onSuccess;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddMonthDailyBudgetState();
}

class _AddMonthDailyBudgetState extends ConsumerState<AddMonthDailyBudget> {
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO NEED to create budbget really, not expense
    ref.listen(
      createExpenseControllerProvider,
      _onListenCreateExpenseControllerProvider,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
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
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // TODO formate Date now to show month name
                  "NOVEMBER, 2024",
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.calendar_month),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    // TODO value here should be valitated, so we could have anohter controller that validates this. for now leave as is. but later, add input vaidator of some kind
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: "Amount",
                      hintText: "Enter amount",
                      suffixIcon: Icon(Icons.credit_card),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 12, top: 0),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    decoration: const InputDecoration(
                      labelText: "Currency",
                      hintText: "Select currency",
                    ),
                    value: "EUR",
                    onChanged: (String? value) {},
                    // TODO for now only one
                    items: <String>["EUR"]
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
            GestureDetector(
              onTap: () {
                final value = amountController.text;
                if (value.isEmpty) {
                  return;
                }

                final int? amount = int.tryParse(value);
                if (amount == null) {
                  return;
                }

                ref
                    .read(createExpenseControllerProvider.notifier)
                    .onCreateExpense(
                      date: DateTime.now(),
                      amount: amount,
                      note: null,
                      categoryId: 1,
                    );

                // Navigator.pop(context);
                // onClose();
                // TODO maybe onClose would be better to call in on listener

                // context.read<CreateMonthDailyBudgetCubit>().onCreateBudget(
                //       date: DateTime.now(),
                //       amount: amount,
                //     );
              },
              child: const Column(
                children: [
                  // Builder(
                  //   builder: (context) {
                  //     final CreateMonthDailyBudgetCubitState state =
                  //         context.watch<CreateMonthDailyBudgetCubit>().state;

                  //     if (state is CreateMonthDailyBudgetCubitStateLoading) {
                  //       return const CircularProgressIndicator();
                  //     }

                  //     return const Icon(
                  //       Icons.check,
                  //       size: 40,
                  //     );
                  //   },
                  // ),
                  Icon(
                    Icons.check,
                    size: 40,
                  ),
                  Text("Save"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onListenCreateExpenseControllerProvider(
    AsyncValue<CreateExpenseControllerState>? os,
    AsyncValue<CreateExpenseControllerState> ns,
  ) {
    final state = ns;
    if (state is! AsyncData) {
      return;
    }

    final data = state.value;
    if (data == null) {
      return;
    }

    final id = data.createdExpenseId;
    if (id == null) {
      return;
    }

    widget.onSuccess();
  }
}

// class AddMonthDailyBudget2 extends ConsumerWidget {
//   const AddMonthDailyBudget2({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "ADD DAILY BUDGET",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         Column(
//           children: [
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   // TODO formate Date now to show month name
//                   "NOVEMBER, 2024",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 Icon(Icons.calendar_month),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 const Expanded(
//                   child: TextField(
//                     // TODO value here should be valitated, so we could have anohter controller that validates this. for now leave as is. but later, add input vaidator of some kind
//                     keyboardType: TextInputType.number,
//                     // controller: amountController,
//                     decoration: InputDecoration(
//                       labelText: "Amount",
//                       hintText: "Enter amount",
//                       suffixIcon: Icon(Icons.credit_card),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     icon: const Padding(
//                       padding: EdgeInsets.only(right: 12, top: 0),
//                       child: Icon(Icons.arrow_drop_down),
//                     ),
//                     decoration: const InputDecoration(
//                       labelText: "Currency",
//                       hintText: "Select currency",
//                     ),
//                     value: "EUR",
//                     onChanged: (String? value) {},
//                     // TODO for now only one
//                     items: <String>["EUR"]
//                         .map(
//                           (e) => DropdownMenuItem(
//                             value: e,
//                             child: Text(e),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             GestureDetector(
//               onTap: () {
//                 // final value = amountController.text;
//                 // if (value.isEmpty) {
//                 //   return;
//                 // }

//                 // final int? amount = int.tryParse(value);
//                 // if (amount == null) {
//                 //   return;
//                 // }

//                 // Navigator.pop(context);
//                 // onClose();
//                 // TODO maybe onClose would be better to call in on listener

//                 // context.read<CreateMonthDailyBudgetCubit>().onCreateBudget(
//                 //       date: DateTime.now(),
//                 //       amount: amount,
//                 //     );
//               },
//               child: const Column(
//                 children: [
//                   // Builder(
//                   //   builder: (context) {
//                   //     final CreateMonthDailyBudgetCubitState state =
//                   //         context.watch<CreateMonthDailyBudgetCubit>().state;

//                   //     if (state is CreateMonthDailyBudgetCubitStateLoading) {
//                   //       return const CircularProgressIndicator();
//                   //     }

//                   //     return const Icon(
//                   //       Icons.check,
//                   //       size: 40,
//                   //     );
//                   //   },
//                   // ),
//                   Icon(
//                     Icons.check,
//                     size: 40,
//                   ),
//                   Text("Save"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
