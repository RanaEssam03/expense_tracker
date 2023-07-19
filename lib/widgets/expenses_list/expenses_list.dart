import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expenses,
    required this.onDismissedFun,
    super.key,
  });

  final List<Expense> expenses;
  final Function onDismissedFun;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.black,
            size: 40,
            shadows: [
              Shadow(
                color: Theme.of(context).colorScheme.primaryContainer,
                blurRadius: 15,
              ),
            ],
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onDismissedFun(expenses[index]);
        },
        direction: DismissDirection.endToStart,
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
