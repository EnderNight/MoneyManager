class Expense {
  final double amount;
  final String desc;
  final DateTime date;

  const Expense({
    required this.amount,
    required this.desc,
    required this.date,
  });

  Map<String, Object?> toMap() {
    return {
      'amount': amount,
      'desc': desc,
      'date': date,
    };
  }

  factory Expense.fromMap(Map<dynamic, dynamic> map) {
    return Expense(
      amount: map['amount'],
      desc: map['desc'],
      date: map['date'],
    );
  }

  @override
  String toString() {
    return 'Expense: $amount, $desc, $date';
  }

  @override
  bool operator ==(Object other) {
    if (other is Expense) {
      return amount == other.amount && desc == other.desc && date == other.date;
    }

    return false;
  }

  // For == overloading
  @override
  int get hashCode => Object.hash(amount, desc, date);
}
