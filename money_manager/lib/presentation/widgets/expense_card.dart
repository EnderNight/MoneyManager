import 'package:flutter/material.dart';
import 'package:money_manager/core/utils/date_formatter.dart';
import 'package:money_manager/data/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final void Function()? onTap;

  const ExpenseCard({
    super.key,
    required this.expense,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(expense.desc),
        subtitle: Text(formatDate(expense.date)),
        trailing: Text(
          expense.amount.toStringAsFixed(2),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onTap: onTap,
      ),
    );
  }
}
