import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/app.dart';
import 'package:money_manager/data/models/expense.dart';

void main() async {
  Hive.registerAdapter(ExpenseAdapter());

  await Hive.initFlutter();
  runApp(const MoneyManagerApp());
}
