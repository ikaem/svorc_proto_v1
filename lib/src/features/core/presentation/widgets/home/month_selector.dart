import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/edit_month_daily_budget.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({
    super.key,
    required this.onMonthSelection,
  });

  final void Function(SelectedMonth? selectedMonth) onMonthSelection;

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
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
