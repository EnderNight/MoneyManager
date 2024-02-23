import 'package:flutter/material.dart';
import 'package:money_manager/widget/money_expense_card.dart';

import '../data/model/money_expanse.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final MoneyExpense expense = MoneyExpense(
    amount: 130,
    dateTime: DateTime.now(),
    motive: "Just a simple test",
    expenseType: ExpenseType.benefice,
    supportType: SupportType.debitCard,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
      ),
      body: Center(
        child: MoneyExpenseCard(
          expense: expense,
        ),
      ),
    );
  }
}
