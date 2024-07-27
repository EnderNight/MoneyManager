import 'package:hive/hive.dart';
import 'package:money_manager/features/expenses/domain/entities/expense.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 1)
class ExpenseModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final DateTime date;

  const ExpenseModel({
    required this.id,
    required this.amount,
    required this.desc,
    required this.date,
  });

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      amount: expense.amount,
      desc: expense.desc,
      date: expense.date,
    );
  }

  Expense toEntity() {
    return Expense(
      id: id,
      amount: amount,
      desc: desc,
      date: date,
    );
  }
}
