import 'dart:io';

import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/data/database.dart';
import 'package:excel/excel.dart';
import 'package:money_manager/data/expense.dart';

class ImportExportPage extends StatelessWidget {
  final Database db;

  const ImportExportPage({
    super.key,
    required this.db,
  });

  Future<void> exportExcel() async {
    List<Expense> expenses = db.get();
    Excel excel = Excel.createExcel();
    Sheet sheet = excel['expenses'];

    excel.delete('Sheet1');

    var rows = expenses
        .map((expense) => [
              DoubleCellValue(expense.amount),
              TextCellValue(expense.desc),
              DateCellValue(
                year: expense.date.year,
                month: expense.date.month,
                day: expense.date.day,
              ),
            ])
        .toList();

    for (var row in rows) {
      sheet.appendRow(row);
    }

    List<int>? fileBytes = excel.save();
    String? userDirectory = await FilePicker.platform.getDirectoryPath();

    if (fileBytes != null && userDirectory != null) {
      File(join('$userDirectory/expenses.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }
  }

  Future<void> importExcel() async {}

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
                  await exportExcel();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Exported database')));
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.upload),
                label: const Text('Export database'),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  await importExcel();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Imported database')));
                    Navigator.of(context).pop();
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
