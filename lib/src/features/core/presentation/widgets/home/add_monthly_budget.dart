import 'package:flutter/material.dart';

class AddMonthlyBudget extends StatelessWidget {
  const AddMonthlyBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Column(
                    children: [
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
        ),
      ),
    );
  }
}
