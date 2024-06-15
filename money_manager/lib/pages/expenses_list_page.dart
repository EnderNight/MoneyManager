import 'package:flutter/material.dart';
import 'package:money_manager/pages/add_expense_page.dart';

class ExpensesListPage extends StatelessWidget {
  const ExpensesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.sync))
        ],
      ),
      body: const Center(
        child: Text("Expenses list"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddExpensePage()));
        },
        tooltip: "Add a new expense",
        child: const Icon(Icons.add),
      ),
    );
  }
}
