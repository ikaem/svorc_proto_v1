import 'package:flutter_test/flutter_test.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';

void main() {
  group(
    MonthBalanceCalculationHelper,
    () {
      group(
        "datesBalances",
        () {
          test(
            "given <pre-condition to the test>"
            "when <behavior we are specifying>"
            "then should <state we expect to happen>",
            () async {
              final expenses = List.generate(
                11,
                (index) => ExpenseModel(
                  id: index + 1,
                  date: DateTime.now().add(Duration(days: index)),
                  amount: 100 * (index + 1),
                  category: CategoryModel(
                    id: index + 1,
                    name: "Category $index",
                  ),
                ),
              );

              final calculator = MonthBalanceCalculationHelper(
                monthExpenses: expenses,
                dailyBudget: 600,
                monthDate: DateTime.now(),
              );

              final balances = calculator.datesBalances;
              final todayBalance = calculator.todayBalance;
              final weekBalance = calculator.weekBalance;
              final monthBalance = calculator.monthBalance;

              // TODO this needs to be tested, and something needs to be expected

              expect(balances, []);
            },
          );
        },
      );
    },
  );
}
