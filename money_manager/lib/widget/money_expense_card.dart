import 'package:flutter/material.dart';
import 'package:money_manager/data/model/money_expanse.dart';

class MoneyExpenseCard extends StatelessWidget {
  const MoneyExpenseCard({
    super.key,
    required this.expense,
  });

  final MoneyExpense expense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(expense.amount.toString()),
        Text(expense.dateTime.toString()),
        Text(expense.motive.toString()),
        Text(expense.expenseType.toString()),
        Text(expense.supportType.toString()),
      ],
    );
  }
}
