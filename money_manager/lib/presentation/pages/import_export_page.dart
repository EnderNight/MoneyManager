import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/data/models/expense.dart';
import 'package:money_manager/presentation/blocs/expense/expense_bloc.dart';
import 'package:money_manager/core/expense_csv.dart';

class ImportExportPage extends StatelessWidget {
  const ImportExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Import/Export'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  final repo = BlocProvider.of<ExpenseBloc>(context).repository;
                  final expenses = await repo.getExpenses();

                  final selectedDir =
                      await FilePicker.platform.getDirectoryPath();

                  if (selectedDir != null) {
                    await ExpenseCsv.write(expenses, selectedDir);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Exported database')));
                    }
                  }
                },
                icon: const Icon(Icons.upload),
                label: const Text('Export database'),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  final repo = BlocProvider.of<ExpenseBloc>(context).repository;
                  final pickerResult = await FilePicker.platform.pickFiles();

                  if (pickerResult != null) {
                    final filePath = pickerResult.files.first.path!;

                    try {
                      List<Expense> csvExpenses = ExpenseCsv.read(filePath);
                      final localExpenses = await repo.getExpenses();

                      csvExpenses = csvExpenses
                          .where((expense) => !localExpenses.contains(expense))
                          .toList();

                      await repo.addExpenses(csvExpenses);
                      if (context.mounted) {
                        BlocProvider.of<ExpenseBloc>(context)
                            .add(LoadExpensesEvent());

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Imported database')));
                      }
                    } on FileSystemException catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('$e')));
                      }
                    }
                  }
                },
                icon: const Icon(Icons.download),
                label: const Text('Import database'),
              ),
            ],
          ),
        ));
  }
}
