import 'package:hive/hive.dart';

import '../data/model/money_expanse.dart';

class Database {
  static final Database _database = Database._internal();

  static final Box _box = Hive.box("moneyBox");
  static List<List<dynamic>> expenses = [];

  Database._internal();

  List get getExpenses => expenses;

  factory Database() {
    var exps = _box.get("expenses");

    if (exps != null) {
      for (var exp in exps) {
        expenses.add(exp);
      }
    }

    return _database;
  }

  void addExpense(MoneyExpense expense) {
    expenses.add(expense.toList());
    _box.put("expenses", expenses);
  }

  void deleteExpenseAt(int index) {
    expenses.removeAt(index);
    _box.put("expenses", expenses);
  }
}
