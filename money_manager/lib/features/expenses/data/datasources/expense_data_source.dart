import 'package:hive/hive.dart';
import 'package:money_manager/features/expenses/data/models/expense_model.dart';

class ExpenseDataSource {
  final Box<ExpenseModel> expenseBox;

  const ExpenseDataSource({required this.expenseBox});

  Future<List<ExpenseModel>> getAllExpenses() async {
    return expenseBox.values.toList();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await expenseBox.put(expense.id, expense);
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await expenseBox.put(expense.id, expense);
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    await expenseBox.delete(expense.id);
  }
}
