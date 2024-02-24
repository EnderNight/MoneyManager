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

  MoneyExpense.fromList(List<dynamic> values)
      : this(
          amount: values[0],
          dateTime: values[1],
          motive: values[2],
          expenseType: expenseTypeFromString(values[3]),
          supportType: supportTypeFromString(values[4]),
        );

  double amount;
  DateTime dateTime;
  String motive;
  ExpenseType expenseType;
  SupportType supportType;

  List toList() {
    return [
      amount,
      dateTime,
      motive,
      expenseTypeToString(expenseType),
      supportTypeToString(supportType)
    ];
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

  static ExpenseType expenseTypeFromString(String type) {
    if (type == "Expense") return ExpenseType.expense;
    return ExpenseType.benefice;
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

  static SupportType supportTypeFromString(String type) {
    if (type == "Debit Card") {
      return SupportType.debitCard;
    } else if (type == "Transfer") {
      return SupportType.transfer;
    }
    return SupportType.cash;
  }
}
