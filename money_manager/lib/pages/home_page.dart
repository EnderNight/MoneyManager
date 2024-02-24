import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/model/money_expanse.dart';
import '../pages/expense_creation_page.dart';
import '../widgets/money_expense_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Database db = Database();

  void onAddExpense(BuildContext context) async {
    final res = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ExpenseCreationPage()));

    if (!context.mounted) return;

    if (res != null) {
      setState(() {
        db.addExpense(res);
      });
    }
  }

  void onDeleteExpense(int index) {
    setState(() {
      db.deleteExpenseAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
      ),
      body: ListView.builder(
        itemCount: db.getExpenses.length,
        itemBuilder: (context, index) {
          return MoneyExpenseCard(
            onTap: () => onDeleteExpense(index),
            expense: MoneyExpense.fromList(db.getExpenses[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAddExpense(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
