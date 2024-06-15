import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  double amount;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isLocal;

  Expense({
    required this.amount,
    required this.date,
    required this.description,
    required this.isLocal,
  });

  Expense.fromJson(Map<String, dynamic> json)
      : amount = json["amount"],
        date = DateTime.parse(json["date"]),
        description = json["description"],
        isLocal = false;

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "date": date.toIso8601String(),
      "description": description,
    };
  }
}
