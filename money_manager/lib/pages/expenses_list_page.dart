import 'package:flutter/material.dart';
import 'package:money_manager/data/models/expense.dart';
import 'package:money_manager/data/services/hive_service.dart';
import 'package:money_manager/data/services/network_service.dart';
import 'package:money_manager/pages/add_expense_page.dart';

class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key});

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage> {
  final HiveService _hiveService = HiveService();
  final NetworkService _networkService = NetworkService();
  final _formKey = GlobalKey<FormState>();

  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final expenses = await _hiveService.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  Future<void> _addExpense(Expense expense) async {
    await _hiveService.addExpense(expense);
    _loadExpenses();
  }

  Future<void> _clearExpenses() async {
    await _hiveService.clearExpenses();
    _expenses.clear();
  }

  Future<void> _syncExpenses() async {
    final ipController = TextEditingController();
    final authority = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Server IP"),
            content: Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  var ipRegexp = RegExp(r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}");
                  if (value == null || value.isEmpty) {
                    return "Please, enter an IPv4 address.";
                  }
                  if (!ipRegexp.hasMatch(value)) {
                    return "Please, enter a valid IPv4 address.";
                  }
                  return null;
                },
                controller: ipController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter the server ip address"),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(ipController.text);
                  }
                },
                child: const Text("Sync"),
              )
            ],
          );
        });

    var expenses = await _networkService.syncExpenses(_expenses, authority);

    await _clearExpenses();

    await _hiveService.addExpenses(expenses);

    await _loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        actions: <Widget>[
          IconButton(
            onPressed: () => _syncExpenses(),
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
