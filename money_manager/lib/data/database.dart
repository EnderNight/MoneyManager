import 'package:hive/hive.dart';
import 'package:money_manager/data/expense.dart';

class Database {
  final _box = Hive.box('expenses');
  final _keyName = 'expenses';

  Database() {
    if (_box.get(_keyName) == null) _box.put(_keyName, []);
  }

  void _save(List<Expense> expenses) {
    _box.put(_keyName, expenses.map((ele) => ele.toMap()).toList());
  }

  void create(Expense expense) {
    var expenses = get();

    expenses.add(expense);

    _save(expenses);
  }

  void createAll(List<Expense> expenses) {
    var localExpenses = get();

    for (final expense in expenses) {
      if (!localExpenses.contains(expense)) localExpenses.add(expense);
    }

    _save(localExpenses);
  }

  List<Expense> get() {
    var expenses = _box.get(_keyName) as List<dynamic>;

    return expenses.map((ele) => Expense.fromMap(ele)).toList();
  }

  void update(Expense expense, int index) {
    var expenses = get();

    expenses[index] = expense;

    _save(expenses);
  }

  void delete(int index) {
    var expenses = get();

    expenses.removeAt(index);

    _save(expenses);
  }

  double getIncomeTotal() {
    var expenses = get();

    return expenses.fold(
        0.0, (cur, expense) => cur + (expense.amount > 0 ? expense.amount : 0));
  }

  double getExpenseTotal() {
    var expenses = get();

    return expenses.fold(
        0.0, (cur, expense) => cur + (expense.amount < 0 ? expense.amount : 0));
  }
}
