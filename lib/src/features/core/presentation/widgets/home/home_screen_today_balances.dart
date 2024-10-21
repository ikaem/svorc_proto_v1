import 'package:flutter/material.dart';

class HomeScreenTodayBalances extends StatelessWidget {
  const HomeScreenTodayBalances({
    super.key,
    required this.accumulation,
    required this.spent,
    required this.remainder,
  });

  final int accumulation;
  final int spent;
  final int remainder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TODAY",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.calendar_view_day,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        // Accumulated remainder
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Accumulated Remainder",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.info,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              // "-11 EUR",
              // TODO maybe this needs to be formated
              "$accumulation EUR",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                // TODO color needs to be adjusted too
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        // Other balances
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "Spent",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.info,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  // "7 EUR",
                  // TODO maybe this needs to be formated
                  "$spent EUR",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "Remainder",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.info,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  // "1 EUR",
                  // TODO maybe this needs to be formated
                  "$remainder EUR",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
