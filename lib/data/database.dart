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

  List<Expense> get() {
    var expenses = _box.get(_keyName) as List<dynamic>;

    if (expenses.isEmpty) return [];

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
}
