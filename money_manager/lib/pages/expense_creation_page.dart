import 'package:flutter/material.dart';
import 'package:money_manager/data/model/money_expanse.dart';

class ExpenseCreationPage extends StatelessWidget {
  const ExpenseCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add a new expense"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: _ExpenseForm(),
      ),
    );
  }
}

class _ExpenseForm extends StatefulWidget {
  const _ExpenseForm();

  @override
  State<_ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<_ExpenseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ExpenseType expenseType = ExpenseType.expense;
  SupportType supportType = SupportType.debitCard;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController motiveController = TextEditingController();

  String? amountValidator(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Please enter the amount';
      }

      double amount = double.parse(value);

      if (amount < 0) return 'Amount must be positive';
    } catch (e) {
      return 'Incorrect amount';
    }
    return null;
  }

  String? motiveValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please provide a motive';

    return null;
  }

  void onExpenseSelected(Set<ExpenseType>? values) {
    setState(() {
      expenseType = values!.first;
    });
  }

  void onSupportSelected(Set<SupportType>? values) {
    setState(() {
      supportType = values!.first;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        MoneyExpense(
            amount: double.parse(amountController.text),
            dateTime: DateTime.now(),
            motive: motiveController.text,
            expenseType: expenseType,
            supportType: supportType),
      );
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    motiveController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                const Divider(),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Amount in euros')),
                _ExpenseTextField(
                  label: 'Amount',
                  validator: amountValidator,
                  textInputType: TextInputType.number,
                  controller: amountController,
                ),
                const Divider(),
                const Text('Motive of the expense'),
                _ExpenseTextField(
                  label: 'Motive',
                  validator: motiveValidator,
                  textInputType: TextInputType.text,
                  controller: motiveController,
                ),
                const Divider(),
                const Text('Expense type'),
                _ExpenseTypeChoice(
                  expenseType: expenseType,
                  onChanged: onExpenseSelected,
                ),
                const Divider(),
                const Text('Support type'),
                _SupportTypeChoice(
                  supportType: supportType,
                  onChanged: onSupportSelected,
                )
              ],
            ),
          ),
          _SubmitFormButton(
            formKey: _formKey,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}

class _ExpenseTextField extends StatelessWidget {
  const _ExpenseTextField({
    required this.validator,
    required this.label,
    required this.textInputType,
    required this.controller,
  });

  final String? Function(String?) validator;
  final String label;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(label),
        ),
        validator: validator,
      ),
    );
  }
}

class _ExpenseTypeChoice extends StatelessWidget {
  const _ExpenseTypeChoice({
    required this.expenseType,
    required this.onChanged,
  });

  final ExpenseType expenseType;
  final void Function(Set<ExpenseType>?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SegmentedButton(
        segments: [
          for (var type in ExpenseType.values)
            ButtonSegment(
                value: type,
                icon: const Icon(Icons.remove),
                label: Text(MoneyExpense.expenseTypeToString(type)))
        ],
        selected: {expenseType},
        onSelectionChanged: onChanged,
      ),
    );
  }
}

class _SupportTypeChoice extends StatelessWidget {
  const _SupportTypeChoice({
    required this.supportType,
    required this.onChanged,
  });

  final SupportType supportType;
  final void Function(Set<SupportType>?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SegmentedButton(
        segments: [
          for (var type in SupportType.values)
            ButtonSegment(
              value: type,
              label: Text(MoneyExpense.supportTypeToString(type)),
              icon: const Icon(Icons.remove),
            )
        ],
        selected: {supportType},
        onSelectionChanged: onChanged,
      ),
    );
  }
}

class _SubmitFormButton extends StatelessWidget {
  const _SubmitFormButton({
    required this.formKey,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: onSubmit,
        icon: const Icon(Icons.check),
        label: const Text('Submit'),
      ),
    );
  }
}
