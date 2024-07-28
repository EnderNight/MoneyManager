import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/features/expenses/presentation/blocs/expense/expense_bloc.dart';
import 'package:money_manager/features/expenses/data/repositories/expense_repository.dart';
import 'package:money_manager/features/expenses/presentation/pages/expense_list_page.dart';

class MoneyManagerApp extends StatelessWidget {
  final ExpenseRepository repository;

  const MoneyManagerApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ExpenseBloc(repository: repository)..add(LoadExpensesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ExpenseListPage(),
      ),
    );
  }
}
