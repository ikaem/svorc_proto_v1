import 'package:flutter/material.dart';

class DatePickerHelper {
  const DatePickerHelper({
    required this.context,
    required this.initialDate,
    required this.fromDate,
    required this.toDate,
  });

  final BuildContext context;
  final DateTime initialDate;
  final DateTime fromDate;
  final DateTime toDate;

  Future<DateTime?> getDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: fromDate,
      lastDate: toDate,
    );
    return date;
  }
}
