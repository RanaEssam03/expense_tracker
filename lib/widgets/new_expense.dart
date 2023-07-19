import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.fun, {super.key});
  final void Function(Expense e) fun;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? date;
  Category _category = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // _dateController.dispose();
    super.dispose();
  }

  void _openDatePicker() async {
    var now = DateTime.now();
    var start = DateTime(now.year - 1);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: start,
      lastDate: now,
    );
    setState(() {
      date = pickedDate;
    });
  }

  void submitExpense() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text);
    final notValidAmount = (amount == null || amount <= 0);

    if (title.isEmpty || notValidAmount || date == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Inavlid Input'),
              content: const Text('Please enter valid data, title and amount'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          });
      return;
    }
    widget.fun(
      Expense(title: title, amount: amount, date: date!, category: _category),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 55, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text(
                'Title',
              ),
            ),
            maxLength: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(date != null
                        ? formatter.format(date!)
                        : "Selected Date"),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: _openDatePicker,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              DropdownButton(
                  value: _category,
                  items: Category.values
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (c) {
                    if (c == null) {
                      return;
                    }
                    setState(() {
                      _category = c;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => submitExpense(),
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// another approach to deal with the values of the textfields by a variable 
  // String _title = '';
  // void _saveTitle(String input) {
  //   _title = input;
  // }


// another approach to deal with the future values 

  // void _openDatePicker() {
  //   var now = DateTime.now();
  //   var start = DateTime(now.year - 1);

  //   showDatePicker(
  //     context: context,
  //     initialDate: now,
  //     firstDate: start,
  //     lastDate: now,
  //   ).then(
  //     (value) {
  //       setState(
  //         () {
  //           _dateController.text = formatter.format(
  //             value ?? DateTime.now(),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }