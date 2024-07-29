import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final DateTime date;

  const Expense({
    required this.id,
    required this.amount,
    required this.desc,
    required this.date,
  });

  @override
  List<Object?> get props => [amount, desc, date];

  Expense copyWith({int? id, double? amount, String? desc, DateTime? date}) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      desc: desc ?? this.desc,
      date: date ?? this.date,
    );
  }
}
