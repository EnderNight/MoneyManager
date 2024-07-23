import 'package:flutter/material.dart';

void main() {
  runApp(const MoneyManagerApp());
}

class MoneyManagerApp extends StatelessWidget {
  const MoneyManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final expenses = [
    Expense(
      amount: 1.0,
      desc: "Piece found at playa",
      date: DateTime.now(),
    ),
    Expense(
      amount: -12.5,
      desc: "Resto portugual",
      date: DateTime.parse("2023-12-12"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) =>
              ExpenseWidget(expense: expenses[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Expense? expense = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddExpensePage()));

          if (expense == null) return;

          setState(() {
            expenses.add(expense);
          });
        },
        tooltip: "Add a new expense",
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Expense {
  final double amount;
  final String desc;
  final DateTime date;

  const Expense({
    required this.amount,
    required this.desc,
    required this.date,
  });
}

class ExpenseWidget extends StatelessWidget {
  final Expense expense;

  const ExpenseWidget({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(expense.desc),
        subtitle: Text(expense.date.toString()),
        trailing: Text(expense.amount.toString()),
      ),
    );
  }
}

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AddExpenseForm(
          onAdd: (expense) => Navigator.of(context).pop(expense),
        ),
      ),
    );
  }
}

class AddExpenseForm extends StatefulWidget {
  final void Function(Expense) onAdd;

  const AddExpenseForm({super.key, required this.onAdd});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final descController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    amountController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Amount"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please, enter an amount";
                }

                if (double.tryParse(value) == null) {
                  return "Incorrect amount value";
                }

                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Description"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please, enter a description";
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  double amount = double.parse(amountController.text);
                  String desc = descController.text;
                  DateTime date = DateTime.now();

                  widget.onAdd(Expense(amount: amount, desc: desc, date: date));
                }
              },
              child: const Text("Add")),
        ],
      ),
    );
  }
}
