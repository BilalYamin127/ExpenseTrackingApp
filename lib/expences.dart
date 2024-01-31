

import 'package:expense_tracking/widget/expense_list.dart';
import 'package:expense_tracking/widget/newexpense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracking/model/expense.dart';
import 'package:expense_tracking/chart/chart.dart';

class Expenses extends StatefulWidget{
const  Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expense();
  }
}

class _Expense extends State<Expenses>{
  final List<Expense> _registerExpenses=[
    Expense(amount: 1300.3,
  date: DateTime.now(),
  title: 'flutter course',
  category: Category.work),
  Expense(amount: 14000,
  date: DateTime.now(),
  title: 'Pizza',
  category: Category.food
  ),
    Expense(amount: 100,
        date: DateTime.now(),
        title: 'Burger',
        category: Category.food
    ),
    Expense(amount: 100000,
        date: DateTime.now(),
        title: 'Multan',
        category: Category.travel
    ),
    Expense(
      amount: 700,
        date: DateTime.now(),
        title: 'Shirts',
        category: Category.leisure,
    ),
  ];
  void addModelOverlay (){

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx)=> NewExpense(_addExpense),
    ); }
  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense);
    });

  }
  void _removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);

    setState(() {
      _registerExpenses.remove(expense);

    });
ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:const Text('expense Deleted'),
          duration:const Duration(seconds: 3) ,
          action: SnackBarAction(
            label:'Undo' ,
            onPressed: () {
              setState(() {
                _registerExpenses.insert(expenseIndex, expense);
              });
            },
          ),
        )
    ) ;
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget listContent =const  Center(
        child:  Text('No Expense found! Start Adding Expense ')
    );
  if (_registerExpenses.isNotEmpty){
    listContent= ExpenseList(
      listOfExpense: _registerExpenses,
      omRemovedExpense: _removeExpense,
    );
  }

    return  Scaffold(

      appBar: AppBar(
        title:const Text(' Add Expenses'
        ),
          actions: [
            IconButton(onPressed: addModelOverlay,
                icon: const Icon(Icons.add),
            ),

          ],
        // backgroundColor: Colors.indigoAccent,
      ),
      body: width < 600 ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
         Chart(expenses: _registerExpenses),
       const SizedBox(
          height: 23,
        ),
        Expanded(
            child:  listContent,
        ),
        ],

        )
      : Row(
       children: [
    Expanded(
        child: Chart(expenses: _registerExpenses)),
    const SizedBox(
    height: 23,
    ),
    Expanded(
    child:  listContent,
    ),
      ],
    )
      );


  }

}