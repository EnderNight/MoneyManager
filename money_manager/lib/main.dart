import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/app.dart';
import 'package:money_manager/features/expenses/data/models/expense_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('expenses');

  Hive.registerAdapter(ExpenseModelAdapter());

  runApp(const MoneyManagerApp());
}
