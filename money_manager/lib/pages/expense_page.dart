import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/data/expense.dart';

class ExpensePage extends StatefulWidget {
  final String buttonText;
  final String pageTitle;
  final Expense? expense;

  const ExpensePage({
    super.key,
    required this.buttonText,
    required this.expense,
    required this.pageTitle,
  });

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  late TextEditingController _amountController;
  late TextEditingController _descController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();

    _amountController =
        TextEditingController(text: widget.expense?.amount.toString());
    _descController = TextEditingController(text: widget.expense?.desc);
    _dateController = TextEditingController(
        text: dateFormat.format(
            widget.expense == null ? DateTime.now() : widget.expense!.date));
  }

  @override
  void dispose() {
    super.dispose();

    _amountController.dispose();
    _descController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
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
                maxLength: null,
                counterText: null,
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
                maxLength: 50,
                counterText: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter a description';
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: _dateController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Date'),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: widget.expense == null
                              ? DateTime.now()
                              : widget.expense!.date,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2100),
                        );

                        if (newDate == null) return;

                        _dateController.text = dateFormat.format(newDate);
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double realAmount = double.parse(_amountController.text);

                    double amount = double.parse(realAmount.toStringAsFixed(2));
                    String desc = _descController.text;
                    DateTime date = DateTime.parse(_dateController.text);

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
  final int? maxLength;
  final String? counterText;

  const _ExpenseTextField({
    required this.controller,
    required this.validator,
    required this.label,
    required this.keyBoardType,
    required this.maxLength,
    required this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyBoardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(label),
          counterText: counterText,
        ),
      ),
    );
  }
}
