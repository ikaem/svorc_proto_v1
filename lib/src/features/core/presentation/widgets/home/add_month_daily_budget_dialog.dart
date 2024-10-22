import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/bloc/cubits/create_month_daily_budget/create_month_daily_budget_cubit.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/create_month_daily_budget_use_case.dart';

// TODO this whole widget needs a lot of work now

// TODO not sure if DialogWidgets belong here
// TODO or maybe this should be widget only, and parent should use the dialog wrapper
// TODO also should be called CreateMonthDailyBudgetDialog, becasue this is how the cubit is called
// TODO this should probably use some kind of DialogWrapper that we will have
class AddMonthDailyBudgetDialog extends StatefulWidget {
  const AddMonthDailyBudgetDialog({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  State<AddMonthDailyBudgetDialog> createState() =>
      _AddMonthDailyBudgetDialogState();
}

class _AddMonthDailyBudgetDialogState extends State<AddMonthDailyBudgetDialog> {
// TODO for now text controller, but later maybe some kind of input validator that will keep validated input state
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateMonthDailyBudgetCubit>(
      create: (context) {
        final PeriodDailyBudgetsRepository budgetsRepository =
            context.read<PeriodDailyBudgetsRepository>();
        final CreateMonthDailyBudgetUseCase createMonthDailyBudgetUseCase =
            CreateMonthDailyBudgetUseCase(budgetsRepository);

        final CreateMonthDailyBudgetCubit createMonthDailyBudgetCubit =
            CreateMonthDailyBudgetCubit(
          createMonthDailyBudgetUseCase: createMonthDailyBudgetUseCase,
        );
        return createMonthDailyBudgetCubit;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(
            // TODO not sure if it is needed
            // bottom: MediaQuery.of(context).viewInsets.bottom,
            bottom: 15,
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
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
                        "NOVEMBER, 2024",
                        style: TextStyle(
                          fontSize: 16,
                        ),
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
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        final value = amountController.text;
                        if (value.isEmpty) {
                          return;
                        }

                        final int? amount = int.tryParse(value);
                        if (amount == null) {
                          return;
                        }

                        // Navigator.pop(context);
                        // onClose();
                        // TODO maybe onClose would be better to call in on listener

                        context
                            .read<CreateMonthDailyBudgetCubit>()
                            .onCreateBudget(
                              date: DateTime.now(),
                              amount: amount,
                            );
                      },
                      child: Column(
                        children: [
                          Builder(builder: (context) {
                            final CreateMonthDailyBudgetCubitState state =
                                context
                                    .watch<CreateMonthDailyBudgetCubit>()
                                    .state;

                            if (state
                                is CreateMonthDailyBudgetCubitStateLoading) {
                              return const CircularProgressIndicator();
                            }

                            return const Icon(
                              Icons.check,
                              size: 40,
                            );
                          }),
                          const Text("Save"),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
