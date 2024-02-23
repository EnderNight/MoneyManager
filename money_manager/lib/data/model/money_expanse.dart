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

  static String expenseTypeToString(ExpenseType type) {
    switch (type) {
      case ExpenseType.expense:
        return "Expense";
      case ExpenseType.benefice:
        return "Benefice";
    }
  }

  static String supportTypeToString(SupportType type) {
    switch (type) {
      case SupportType.debitCard:
        return "Debit Card";
      case SupportType.transfer:
        return "Transfer";
      case SupportType.cash:
        return "Cash";
    }
  }
}
