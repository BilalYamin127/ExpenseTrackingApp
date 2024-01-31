import 'package:flutter/material.dart';
import 'package:expense_tracking/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  DateTime? selectedDate;
  Category selectedCategory = Category.food;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final datePicked = await showDatePicker(
        context: context,
        firstDate: firstDate,
        initialDate: now,
        lastDate: now);
    setState(() {
      selectedDate = datePicked;
    });
  }

  void _btnSubmitExpense() {
    final amountEntered = double.tryParse(amountController.text);

    final amountIsNotValid = amountEntered == null || amountEntered <= 0;
    if (titleController.text.isEmpty ||
        amountIsNotValid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Inputs'),
          content:
              const Text('please entered valid title,date,amount and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okey"),
            )
          ],
        ),
      );
      return;
    } else {
      widget.onAddExpense(Expense(
          amount: amountEntered,
          date: selectedDate!,
          title: titleController.text,
          category: selectedCategory));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraints){
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, keyboard + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  // onChanged: _addTitle,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: ("Title "),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        // onChanged: _addTitle,
                        keyboardType: TextInputType.number,

                        decoration: const InputDecoration(
                          labelText: ("Amount "),
                          prefixText: '\$ ',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            selectedDate == null
                                ? 'No Date Selected '
                                : formatter.format(selectedDate!),
                          ),
                          IconButton(
                              onPressed: presentDatePicker,
                              icon: const Icon(Icons.calendar_month)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton(
                        value: selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              )),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _btnSubmitExpense,
                      child: const Text('Submit Expense'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

  }
}
