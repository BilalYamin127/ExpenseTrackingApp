import 'package:expense_tracking/main.dart';
import 'package:expense_tracking/widget/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracking/model/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.listOfExpense,
    required this.omRemovedExpense,
  });

  final void Function(Expense expense) omRemovedExpense;

  final List<Expense> listOfExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listOfExpense.length,
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(listOfExpense[index]),
            background: Container(
              color: Colors.red,
              // color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal
              ),
            ),
            onDismissed: (direction) {
              omRemovedExpense(listOfExpense[index]);
            },
            child: ExpenseItems(expense: listOfExpense[index])));
  }
}
