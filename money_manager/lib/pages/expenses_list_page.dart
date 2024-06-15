import 'package:flutter/material.dart';
import 'package:money_manager/data/models/expense.dart';
import 'package:money_manager/data/services/hive_service.dart';
import 'package:money_manager/pages/add_expense_page.dart';

class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key});

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage> {
  final HiveService hiveService = HiveService();
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final expenses = await hiveService.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  Future<void> _addExpense(Expense expense) async {
    await hiveService.addExpense(expense);
    _loadExpenses();
  }

  Future<void> _clearExpenses() async {
    await hiveService.clearExpenses();
    _loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sync),
            tooltip: "Synchronize with the database",
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          final expense = _expenses[index];
          return ListTile(
            title: Text(expense.description),
            subtitle:
                Text("${expense.amount.toStringAsFixed(2)}€ - ${expense.date}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddExpensePage()));

          if (res is Expense) {
            _addExpense(res);
          }
        },
        tooltip: "Add a new expense",
        child: const Icon(Icons.add),
      ),
    );
  }
}
