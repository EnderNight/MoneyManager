import 'package:flutter/material.dart';
import 'package:money_manager/data/expense.dart';

class ExpensePage extends StatefulWidget {
  final String buttonText;
  final Expense? expense;

  const ExpensePage({
    super.key,
    required this.buttonText,
    required this.expense,
  });

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();

    _amountController =
        TextEditingController(text: widget.expense?.amount.toString());
    _descController = TextEditingController(text: widget.expense?.desc);
  }

  @override
  void dispose() {
    super.dispose();

    _amountController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _ExpenseTextField(
                keyBoardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _amountController,
                label: 'Amount',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please, enter an amount";
                  }

                  if (double.tryParse(value) == null) {
                    return "Please, enter a correct amount";
                  }

                  return null;
                },
              ),
              _ExpenseTextField(
                keyBoardType: null,
                controller: _descController,
                label: 'Description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter a description';
                  }

                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double realAmount = double.parse(_amountController.text);

                    double amount = double.parse(realAmount.toStringAsFixed(2));
                    String desc = _descController.text;
                    DateTime date = DateTime.now();

                    Navigator.of(context).pop(Expense(
                      amount: amount,
                      desc: desc,
                      date: date,
                    ));
                  }
                },
                child: Text(widget.buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpenseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final TextInputType? keyBoardType;

  const _ExpenseTextField({
    required this.controller,
    required this.validator,
    required this.label,
    required this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyBoardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(label),
        ),
      ),
    );
  }
}
