import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/data/models/expense.dart';
import 'package:money_manager/presentation/blocs/expense/expense_bloc.dart';
import 'package:money_manager/presentation/widgets/expense_form.dart';

class EditExpensePage extends StatelessWidget {
  final Expense expense;

  const EditExpensePage({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update expense'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<ExpenseBloc>(context)
                  .add(DeleteExpenseEvent(expense.id));

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ExpenseForm(
        buttonIcon: const Icon(Icons.check),
        buttonText: 'Update',
        initExpense: expense,
        onSubmit: (updatedExpense) {
          BlocProvider.of<ExpenseBloc>(context)
              .add(UpdateExpenseEvent(updatedExpense.copyWith(id: expense.id)));

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
