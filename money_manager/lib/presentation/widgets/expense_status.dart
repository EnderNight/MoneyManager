import 'package:flutter/material.dart';
import 'package:money_manager/core/utils/currency_formatter.dart';

class ExpenseStatus extends StatelessWidget {
  final double income;
  final double expense;

  const ExpenseStatus({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            formatCurrency(expense + income),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Income: ${formatCurrency(income)}'),
              Text('Expense: ${formatCurrency(expense)}'),
            ],
          )
        ],
      ),
    );
  }
}
