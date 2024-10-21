import 'package:flutter/material.dart';

class ExpenseBriefItem extends StatelessWidget {
  const ExpenseBriefItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Icon(Icons.credit_card),
            SizedBox(
              width: 10,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "25 EUR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " | ",
                  ),
                  TextSpan(
                    text: "25 October 2021",
                  ),
                  TextSpan(
                    text: " | ",
                  ),
                  TextSpan(
                    text: "16:30",
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.folder),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Utilities",
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.note),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Some note that is a bit longer for testing",
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
