import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/data/expense.dart';

class ExpenseWidget extends StatelessWidget {
  final Expense expense;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final dateFormat = DateFormat('yyyy-MM-dd');
  final amountFormat = NumberFormat.compactCurrency(
    symbol: '€',
    decimalDigits: 2,
  );

  ExpenseWidget({
    super.key,
    required this.expense,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(expense.desc),
          subtitle: Text(dateFormat.format(expense.date)),
          trailing: Text(
            amountFormat.format(expense.amount),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
