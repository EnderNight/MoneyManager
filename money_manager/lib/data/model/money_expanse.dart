enum ExpenseType {
  expense,
  benefice,
}

enum SupportType {
  debitCard,
  transfer,
  cash,
}

class MoneyExpense {
  MoneyExpense({
    required this.amount,
    required this.dateTime,
    required this.motive,
    required this.expenseType,
    required this.supportType,
  });

  double amount;
  DateTime dateTime;
  String motive;
  ExpenseType expenseType;
  SupportType supportType;

  List toList() {
    return [amount, dateTime, motive, expenseType, supportType];
  }

  @override
  String toString() {
    return "MoneyExpense(amount: $amount, "
        "dateTime: $dateTime, "
        "motive: $motive, "
        "expenseType: $expenseType, "
        "supportType: $supportType";
  }
}
