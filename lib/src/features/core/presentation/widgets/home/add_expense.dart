import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/core/utilities/helpers/date_picker_helper.dart';
import 'package:svorc_proto_v1/src/features/core/utilities/helpers/time_picker_helper.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/create_expense/create_expense_controller.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  // TODO lets keep this for now
  late CategoryModel _selectedCategory = _tempCategories.first;

  // TODO maybe this can be handled in a controller as well - do it later
  DateTime _selectedDate = DateTime.now();
  late final TextEditingController _dateController =
      TextEditingController.fromValue(
    TextEditingValue(
      text: _getFormattedDate(DateTime.now()),
    ),
  );

  late TimeOfDay _selectedTime = TimeOfDay.fromDateTime(_selectedDate);
  late final TextEditingController _timeController =
      TextEditingController.fromValue(
    TextEditingValue(
      text: _getFormattedTime(_selectedTime),
    ),
  );

  // TODO we could intialize this from initi state, like in editmonthdailybudget -> new
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // TODO extract to a method

    ref.listenManual(createExpenseControllerProvider, (_, currentState) {
      currentState.when(
        data: (data) {
// if(data == null)

          final id = data.createdExpenseId;
          if (id == null) return;

          widget.onClose();
        },
        error: (error, stackTrace) => null,
        loading: () => null,
      );
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  // TODO move below

  String _getFormattedDate(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }

  String _getFormattedTime(TimeOfDay time) {
    return time.format(context);
  }

  @override
  Widget build(BuildContext context) {
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

                        setState(() {
                          _dateController.text = _getFormattedDate(date);
                          _selectedDate = date;
                        });
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
                        // _timeController.text = time.format(context);

                        setState(() {
                          _timeController.text = _getFormattedTime(time);
                          _selectedTime = time;
                        });
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
                    if (value == null) return;

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

                    ref
                        .read(createExpenseControllerProvider.notifier)
                        .onCreateExpense(
                          date: normalizedDateTime,
                          amount: value,
                          categoryId: categoryId,
                          note: note,
                        );
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
                    widget.onClose();
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
