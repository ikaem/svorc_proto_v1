import 'package:flutter/material.dart';

class TimePickerHelper {
  const TimePickerHelper({
    required this.context,
    required this.initialTime,
  });

  final BuildContext context;
  final TimeOfDay initialTime;

  Future<TimeOfDay?> getTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    return time;
  }
}
