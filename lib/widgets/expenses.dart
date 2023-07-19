import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  final Widget _messaga = const Center(
    child: Text(
      "No expenses found, Start adding some",
      textAlign: TextAlign.center,
    ),
  );

  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 200.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema ",
      amount: 125.0,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _addExpense(Expense e) {
    setState(() {
      _registeredExpenses.add(e);
    });
  }

  void _removeExpense(Expense e) {
    int index = _registeredExpenses.indexOf(e);
    setState(() {
      _registeredExpenses.remove(e);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(index, e);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              _openAddExpenseOverlay();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _registeredExpenses.isEmpty
          ? _messaga
          : Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: ExpensesList(
                    expenses: _registeredExpenses,
                    onDismissedFun: _removeExpense,
                  ),
                ),
              ],
            ),
    );
  }
}
