import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/core/utilities/helpers/date_picker_helper.dart';
import 'package:svorc_proto_v1/src/features/core/utilities/helpers/time_picker_helper.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/bloc/cubits/create_expense/create_expense_cubit.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/create_expense_use_case.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // TODO this will need to be retrieved from another cubit - and it could hold some state maybe for the future
  late CategoryModel _selectedCategory = _tempCategories.first;

// TODO this is clumsy - we should be handling this in one place
  DateTime _selectedDate = DateTime.now();
  late final TextEditingController _dateController =
      TextEditingController.fromValue(
    TextEditingValue(
      text: DateFormat("dd/MM/yyyy").format(
        DateTime.now(),
      ),
      // text: _selectedDate.toIso8601String(),
    ),
  );

  // TODO create initial value from current time, so can be reused later for pickers as initial time and date
  TimeOfDay _selectedTime = TimeOfDay.fromDateTime(DateTime.now());
  late final TextEditingController _timeController =
      TextEditingController.fromValue(
    TextEditingValue(
        // text: DateFormat("HH:mm").format(
        //   DateTime.now(),
        // ),
        // text: TimeOfDay.now().format(context),
        text: _selectedTime.format(context)),
  );

  final TextEditingController _amountController = TextEditingController();

  // TODO temp

  // TODO we will see how category will be provided - will need to retrieve categories from db

  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // _dateController.addListener((e) {

    // });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final TimeOfDay time = TimeOfDay.now();
    // final formatedTimeOf = time.format(context);

    // log("Time: $formatedTimeOf");

// TODO lets try provide and consume blocs in the same widget
    return Builder(builder: (context) {
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
              TextField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: const InputDecoration(
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
                        _selectedDate = date;
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
                        _selectedTime = time;
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
                value: _selectedCategory.id.toString(),
                onChanged: (String? value) {
                  if (value == null) return;

                  final id = int.tryParse(value);
                  if (id == null) return;

                  final CategoryModel category = _tempCategories.firstWhere(
                    (element) => element.id == id,
                  );

                  setState(() {
                    // _selectedCategory = value!;
                    _selectedCategory = category;
                  });
                },
                items: _tempCategories
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(e.name),
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
                    // TODO this could be called maybe in listener of state
                    // TODO this should be all validate and such
                    final value = int.tryParse(_amountController.text);
                    final date = _selectedDate;
                    final time = _selectedTime;

                    final categoryId = _selectedCategory.id;
                    final note = _noteController.text;

                    final normalizedDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );

                    if (value == null) return;

                    // context.read<CreateExpenseCubit>().onCreateExpense(
                    //       amount: value,
                    //       categoryId: categoryId,
                    //       date: normalizedDateTime,
                    //       note: note,
                    //     );

                    // widget.onClose();
                    print(
                        "Amount: $value, Date: $date, Time: $time, Category: $categoryId, Note: $note");
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
    });
  }
}

// TODO not sure if this is needed in the future?
const List<CategoryModel> _tempCategories = [
  CategoryModel(
    id: 1,
    name: "general",
  ),
  // "Utilities",
  // "Groceries",
  // "Transport",
  // "Entertainment",
  // "Health",
  // "Other",
];

// TODO test
