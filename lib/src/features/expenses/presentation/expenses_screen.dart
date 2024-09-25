import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Column(
          children: <Widget>[
            _ExpensesScreenFilters(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _ExpensesScreenItems(),
            )
          ],
        ),
      ),
    );
  }
}

class _ExpensesScreenItems extends StatelessWidget {
  const _ExpensesScreenItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ExpenseBriefItem();
          },
        ),
      ),
    );
  }
}

class _ExpensesScreenFilters extends StatelessWidget {
  const _ExpensesScreenFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO maybe better like this -> ColoredBox -> Padding because Container is too expensive
    return ColoredBox(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'FILTERS ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return ColoredBox(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              top: 15,
                              left: 15,
                              right: 15,
                            ),
                            child: const _ExpensesScreenEditExpensesFilter(),
                          ),
                        );

                        // TODO replace with colored box > padding, or other way around
                        // return Container(
                        //   color: Colors.red,
                        //   padding: EdgeInsets.only(
                        //     bottom: MediaQuery.of(context).viewInsets.bottom,
                        //     top: 15,
                        //     left: 15,
                        //     right: 15,
                        //   ),
                        // );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.filter_list,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text.rich(
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                        ),
                        TextSpan(
                          children: [
                            TextSpan(text: "Amount: "),
                            TextSpan(
                              text: "1000 EUR - 1500 EUR",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.folder,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text.rich(
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                        ),
                        TextSpan(
                          children: [
                            TextSpan(text: "Categories: "),
                            TextSpan(
                              text:
                                  "Food, Utilities, Rent, Transport, Entertainment, Entertainment, Other, Tech, Social",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text.rich(
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                        ),
                        TextSpan(
                          children: [
                            TextSpan(text: "Date: "),
                            TextSpan(
                              text: "23 January 2024 - 27 July 2024",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpensesScreenEditExpensesFilter extends StatefulWidget {
  const _ExpensesScreenEditExpensesFilter({
    super.key,
  });

  @override
  State<_ExpensesScreenEditExpensesFilter> createState() =>
      _ExpensesScreenEditExpensesFilterState();
}

// TODO move below or to values

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}

class _ExpensesScreenEditExpensesFilterState
    extends State<_ExpensesScreenEditExpensesFilter> {
  // TODO maybe not needed
  final TextEditingController _categoriesTextEditingController =
      TextEditingController();

  final Set<CategoryModel> _selectedCategories = {};

  @override
  void dispose() {
    _categoriesTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EDIT EXPENSES FILTER",
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
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Min amount",
                      hintText: "Enter minumum amount",
                      suffixIcon: Icon(Icons.credit_card),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "To date",
                      hintText: "Select to date",
                      suffixIcon: Icon(Icons.credit_card),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: () async {
                final selectedCategories =
                    await showDialog<List<CategoryModel>>(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        // TODO use ColoredBox > Padding
                        color: Colors.white,
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 15,
                          left: 15,
                          right: 15,
                        ),

                        child: _ExpensesScreenCategoriesSelector(
                          onCategoriesSelection: (selectedCategories) {
                            return Navigator.pop(context, selectedCategories);
                          },
                          selectedCategories: _selectedCategories,
                        ),
                      ),
                    );
                  },
                );

                if (selectedCategories == null) return;

                setState(() {
                  _selectedCategories.clear();
                  _selectedCategories.addAll(selectedCategories);

                  _categoriesTextEditingController.text =
                      selectedCategories.map((e) => e.name).toList().join(", ");
                });
              },
              controller: _categoriesTextEditingController,
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Categories",
                hintText: "Select categories",
                suffixIcon: Icon(Icons.folder),
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
                      labelText: "From date",
                      hintText: "Select from date",
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
                      labelText: "To date",
                      hintText: "Select to date",
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
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
            // DropdownButtonFormField<String>(
            //   icon: const Padding(
            //     padding: EdgeInsets.only(right: 12, top: 0),
            //     child: Icon(Icons.folder),
            //   ),
            //   // padding: const EdgeInsets.all(10),
            //   decoration: const InputDecoration(
            //     labelText: "Category",
            //     hintText: "Enter category",
            //     // suffixIcon: Icon(Icons.folder),
            //   ),
            //   value: _selectedCategory,
            //   onChanged: (String? value) {
            //     setState(() {
            //       _selectedCategory = value!;
            //     });
            //   },
            //   items: categories
            //       .map(
            //         (e) => DropdownMenuItem(
            //           value: e,
            //           child: Text(e),
            //         ),
            //       )
            //       .toList(),
            // ),
          ],
        ),
      ],
    );
  }
}

class _ExpensesScreenCategoriesSelector extends StatefulWidget {
  const _ExpensesScreenCategoriesSelector({
    super.key,
    required this.onCategoriesSelection,
    required this.selectedCategories,
  });

  final void Function(
    List<CategoryModel>? selectedCategories,
  ) onCategoriesSelection;

  final Set<CategoryModel> selectedCategories;

  @override
  State<_ExpensesScreenCategoriesSelector> createState() =>
      _ExpensesScreenCategoriesSelectorState();
}

class _ExpensesScreenCategoriesSelectorState
    extends State<_ExpensesScreenCategoriesSelector> {
  late final Set<CategoryModel> _selectedCategories = {
    ...widget.selectedCategories
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SELECT CATEGORIES",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Wrap(
          spacing: 10,
          children: List.generate(13, (index) {
            final category = CategoryModel(
              id: index,
              name: "Category $index",
            );

            return FilterChip(
              label: Text(category.name),
              selected: _selectedCategories.contains(category),
              // selected: widget.selectedCategories.contains(category),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCategories.add(category);
                  } else {
                    _selectedCategories.remove(category);
                  }
                });
              },
            );
          }),
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
                  // Navigator.pop(context);
                  // widget.onMonthSelection(_selectedMonth);
                  widget.onCategoriesSelection(_selectedCategories.toList());
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
                  // Navigator.pop(context);
                  // widget.onMonthSelection(null);
                  widget.onCategoriesSelection(null);
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
