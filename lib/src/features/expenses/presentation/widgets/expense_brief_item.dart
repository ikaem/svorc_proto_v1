import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';

class ExpenseBriefItem extends StatelessWidget {
  const ExpenseBriefItem({
    super.key,
    required this.id,
    required this.date,
    required this.amount,
    required this.category,
    this.note,
  });

  final int id;
  final DateTime date;
  final int amount;
  final CategoryModel category;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.credit_card),
            const SizedBox(
              width: 10,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    // text: "25 EUR",
                    text: "$amount EUR",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: " | ",
                  ),
                  TextSpan(
                    // text: "25 October 2021",
                    // TODO format this better somehow
                    text: "${date.day} ${date.month} ${date.year}",
                  ),
                  const TextSpan(
                    text: " | ",
                  ),
                  TextSpan(
                    // text: "16:30",
                    // TODO format this better somehow
                    text: "${date.hour}:${date.minute}",
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
              // "Utilities",
              category.name,
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
            if (note != null)
              Text(
                // "Some note that is a bit longer for testing",
                note!,
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              )
          ],
        ),
      ],
    );
  }
}
