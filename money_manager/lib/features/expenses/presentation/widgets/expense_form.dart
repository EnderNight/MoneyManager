import 'package:flutter/material.dart';
import 'package:money_manager/core/utils/date_formatter.dart';
import 'package:money_manager/features/expenses/data/models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final Expense? initExpense;
  final void Function(Expense expense) onSubmit;
  final String buttonText;
  final Icon buttonIcon;

  const ExpenseForm({
    super.key,
    this.initExpense,
    required this.onSubmit,
    required this.buttonText,
    required this.buttonIcon,
  });

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  late TextEditingController _amountController;
  late TextEditingController _descController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();

    String amount = widget.initExpense?.amount.toStringAsFixed(2) ?? '';
    String desc = widget.initExpense?.desc ?? '';
    String date = formatDate(widget.initExpense?.date ?? now);

    _amountController = TextEditingController(text: amount);
    _descController = TextEditingController(text: desc);
    _dateController = TextEditingController(text: date);
    _selectedDate = widget.initExpense?.date ?? now;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _ExpenseTextField(
              controller: _amountController,
              labelText: 'Amount',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please, enter an amount';
                } else if (double.tryParse(value) == null) {
                  return 'Please, enter a valid amount';
                }
                return null;
              },
            ),
            _ExpenseTextField(
              controller: _descController,
              labelText: 'Description',
              maxLength: 50,
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
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (date != null) {
                        setState(() {
                          _dateController.text = formatDate(date);
                          _selectedDate = date;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double amount = double.parse(_amountController.text);
                    String desc = _descController.text;
                    DateTime date = _selectedDate;

                    widget.onSubmit(Expense(
                      id: -1,
                      amount: amount,
                      desc: desc,
                      date: date,
                    ));
                  }
                },
                icon: widget.buttonIcon,
                label: Text(widget.buttonText),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ExpenseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final int? maxLength;

  const _ExpenseTextField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        validator: validator,
      ),
    );
  }
}
