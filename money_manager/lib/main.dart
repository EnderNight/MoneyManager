import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("moneyBox");

  runApp(const MoneyManagerApp());
}

class MoneyManagerApp extends StatelessWidget {
  const MoneyManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const HomePage(),
    );
  }
}
