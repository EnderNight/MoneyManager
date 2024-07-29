import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/app.dart';
import 'package:money_manager/data/models/expense.dart';
import 'package:money_manager/data/repositories/expense_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseAdapter());

  final expenseBox = await Hive.openBox<Expense>('expenses');

  ExpenseRepository repository = ExpenseRepository(expenseBox);

  runApp(MoneyManagerApp(repository: repository));
}
