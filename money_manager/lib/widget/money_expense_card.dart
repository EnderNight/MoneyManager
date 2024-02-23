import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/data/model/money_expanse.dart';

class MoneyExpenseCard extends StatelessWidget {
  const MoneyExpenseCard({
    super.key,
    required this.expense,
  });

  final MoneyExpense expense;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 120),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Card(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${expense.amount.toStringAsFixed(2)} €")),
                ),
                const VerticalDivider(),
                _ExpenseInfoWidget(expense: expense),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpenseInfoWidget extends StatelessWidget {
  const _ExpenseInfoWidget({
    super.key,
    required this.expense,
  });

  final MoneyExpense expense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            expense.motive,
            overflow: TextOverflow.ellipsis,
          )),
          Center(
            child: Column(
              children: [
                Text(MoneyExpense.supportTypeToString(expense.supportType)),
                Text(DateFormat('MMM dd, yyyy | HH:mm')
                    .format(expense.dateTime)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
