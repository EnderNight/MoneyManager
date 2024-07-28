import 'package:hive/hive.dart';
import 'package:money_manager/features/expenses/data/models/expense.dart';

class ExpenseRepository {
  final Box<Expense> expenseBox;

  const ExpenseRepository(this.expenseBox);

  Future<List<Expense>> getExpenses() async {
    return expenseBox.values.toList();
  }

  Future<Expense> addExpense(Expense expense) async {
    int id = _getNextId();

    Expense newExpense = Expense(
      id: id,
      amount: expense.amount,
      desc: expense.desc,
      date: expense.date,
    );

    await expenseBox.put(id, newExpense);

    return newExpense;
  }

  Future<List<Expense>> addExpenses(List<Expense> expenses) async {
    int id = _getNextId();

    final newExpenses = <Expense>[];

    newExpenses.addAll(
      expenses.map(
        (expense) => Expense(
          id: id++,
          amount: expense.amount,
          desc: expense.desc,
          date: expense.date,
        ),
      ),
    );

    final entries = {for (final expense in newExpenses) expense.id: expense};

    await expenseBox.putAll(entries);

    return newExpenses;
  }

  Future<Expense> updateExpense(Expense expense) async {
    await expenseBox.put(expense.id, expense);

    return expense;
  }

  Future<void> deleteExpense(int id) async {
    await expenseBox.delete(id);
  }

  int _getNextId() {
    return expenseBox.length;
  }
}
