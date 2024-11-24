import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/bloc/cubits/get_recent_expenses/get_recent_expenses_cubit.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/get_recent_expenses/get_recent_expenses_controller.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/presentation/expenses_screen.dart';
import 'package:svorc_proto_v1/src/features/expenses/presentation/widgets/expense_brief_item.dart';

class HomeScreenRecentExpenses extends ConsumerWidget {
  const HomeScreenRecentExpenses({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
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
            Builder(builder: (context) {
              final AsyncValue<GetRecentExpensesControllerStateData> state =
                  ref.watch(getRecentExpensesControllerProvider);

              return state.when(
                data: (data) {
                  final List<ExpenseModel> expenses = data.expenses;
                  if (expenses.isEmpty) {
                    return const Center(
                      child: Text("No recent expenses"),
                    );
                  }

                  return Expanded(
                      child: _RecentExpensesPresenter(expenses: expenses));
                },
                error: (error, stackTrace) => const Center(
                  child: Text("There was an issue loading recent expenses"),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _RecentExpensesPresenter extends StatelessWidget {
  const _RecentExpensesPresenter({
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: expenses.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final ExpenseModel expense = expenses[index];
        return ExpenseBriefItem(
          amount: expense.amount,
          date: expense.date,
          category: expense.category,
          note: expense.note,
          id: expense.id,
        );
      },
    );
  }
}
