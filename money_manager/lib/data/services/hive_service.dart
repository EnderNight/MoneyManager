import 'package:hive/hive.dart';
import 'package:money_manager/data/models/expense.dart';

class HiveService {
  static const String expenseBoxName = "expenses";

  Future<void> addExpense(Expense expense) async {
    final box = await Hive.openBox<Expense>(expenseBoxName);
    await box.add(expense);
  }

  Future<List<Expense>> getExpenses() async {
    final box = await Hive.openBox<Expense>(expenseBoxName);
    return box.values.toList();
  }

  Future<void> deleteExpense(int index) async {
    final box = await Hive.openBox<Expense>(expenseBoxName);
    box.deleteAt(index);
  }
}
