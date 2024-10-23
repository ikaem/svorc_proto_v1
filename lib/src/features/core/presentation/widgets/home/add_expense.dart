import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svorc_proto_v1/src/features/core/utilities/helpers/date_picker_helper.dart';
import 'package:svorc_proto_v1/src/features/core/utilities/helpers/time_picker_helper.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
  });

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // TODO this will need to be retrieved from another cubit - and it could hold some state maybe for the future
  String _selectedCategory = categories.first;

  final TextEditingController _dateController = TextEditingController.fromValue(
      TextEditingValue(text: DateFormat("dd/MM/yyyy").format(DateTime.now())));

  // TODO create initial value from current time, so can be reused later for pickers as initial time and date
  final TextEditingController _timeController = TextEditingController.fromValue(
      TextEditingValue(text: DateFormat("HH:mm").format(DateTime.now())));

  // TODO temp

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TimeOfDay time = TimeOfDay.now();
    final formatedTimeOf = time.format(context);

    log("Time: $formatedTimeOf");

    return Column(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // TODO this should be extracted as it is exverywhere, and reused
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ADD EXPENSE",
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
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Enter amount",
                suffixIcon: Icon(Icons.credit_card),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Date",
                      hintText: "Enter date",
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    onTap: () async {
                      final DateTime? date = await DatePickerHelper(
                        context: context,
                        // TODO this should use exact date as initial one
                        initialDate: DateTime.now(),
                        fromDate: DateTime(2021),
                        toDate: DateTime(2025),
                      ).getDate();

                      if (date == null) return;

                      _dateController.text =
                          DateFormat("dd/MM/yyyy").format(date);
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: "Time",
                      hintText: "Enter time",
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      final TimeOfDay? time = await TimePickerHelper(
                        context: context,
                        // TODO should use exact same initial time as initial one
                        initialTime: TimeOfDay.now(),
                      ).getTime();

                      if (!context.mounted) return;

                      if (time == null) return;
                      _timeController.text = time.format(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              icon: const Padding(
                padding: EdgeInsets.only(right: 12, top: 0),
                // child: Icon(Icons.folder),
                child: Icon(Icons.arrow_drop_down),
              ),
              // padding: const EdgeInsets.all(10),
              decoration: const InputDecoration(
                labelText: "Category",
                hintText: "Enter category",
                // suffixIcon: Icon(Icons.folder),
              ),
              value: _selectedCategory,
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              items: categories
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Note",
                hintText: "Enter note",
                // suffixIcon: Icon(Icons.note),
                suffixIcon: Icon(Icons.note),
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
      ],
    );
  }
}

// TODO not sure if this is needed in the future?
const List<String> categories = [
  "Utilities",
  "Groceries",
  "Transport",
  "Entertainment",
  "Health",
  "Other",
];
