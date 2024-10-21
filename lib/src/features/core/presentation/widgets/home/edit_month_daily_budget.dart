import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/widgets/home/month_selector.dart';

// TODO handle this better
const List<String> currencies = [
  "EUR",
];

class EditMonthDailyBudget extends StatefulWidget {
  const EditMonthDailyBudget({super.key});

  @override
  State<EditMonthDailyBudget> createState() => _EditMonthDailyBudgetState();
}

class _EditMonthDailyBudgetState extends State<EditMonthDailyBudget> {
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
                        child: MonthSelector(
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

// TODO not sure where should this belong
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
