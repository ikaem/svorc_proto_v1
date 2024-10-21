import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
  });

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String _selectedCategory = categories.first;

  // TODO temp

  @override
  Widget build(BuildContext context) {
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
            const Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Date",
                      hintText: "Enter date",
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Time",
                      hintText: "Enter time",
                      suffixIcon: Icon(Icons.access_time),
                    ),
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
