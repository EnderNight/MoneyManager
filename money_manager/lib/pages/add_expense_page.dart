import 'package:flutter/material.dart';
import 'package:money_manager/data/models/expense.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final double amount = double.parse(_amountController.text);
      final String desc = _descController.text;

      _amountController.clear();
      _descController.clear();

      final expense = Expense(
        amount: amount,
        date: DateTime.now(),
        description: desc,
        isLocal: true,
      );

      Navigator.of(context).pop(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Expense amount"),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please, enter an amount.";
                  }
                  final double? amount = double.tryParse(value);
                  if (amount == null) {
                    return "Please, enter a valid amount";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 80),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Description"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please, enter a description.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () => _submitForm(),
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
