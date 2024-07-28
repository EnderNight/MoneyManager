import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/features/expenses/presentation/blocs/expense/expense_bloc.dart';
import 'package:money_manager/features/expenses/presentation/widgets/expense_form.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add expense'),
      ),
      body: ExpenseForm(
        buttonIcon: const Icon(Icons.add),
        buttonText: 'Add',
        onSubmit: (expense) {
          BlocProvider.of<ExpenseBloc>(context).add(AddExpenseEvent(expense));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
