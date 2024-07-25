import 'dart:io';

import 'package:intl/intl.dart';
import 'package:money_manager/core/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/data/database.dart';
import 'package:money_manager/data/expense.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ImportExportPage extends StatelessWidget {
  final Database db;

  const ImportExportPage({
    super.key,
    required this.db,
  });

  Future<bool> exportDatabase() async {
    var expenses = db.get();
    var packageInfo = await PackageInfo.fromPlatform();
    var date = DateTime.now();
    var dateFormater = DateFormat('yyyy-MM-dd');
    var fileName =
        'expenses_${dateFormater.format(date)}_v${packageInfo.version}.csv';

    String? destFile;

    if (Platform.isLinux) {
      destFile = await FilePicker.platform.saveFile(
        fileName: fileName,
        dialogTitle: 'Export database',
      );
    } else if (Platform.isAndroid) {
      var result = await FilePicker.platform.getDirectoryPath();

      if (result == null) return false;

      destFile = '$result/$fileName';
    }

    if (destFile == null) return false;

    List<List<String>> rows = [];

    for (final expense in expenses) {
      rows.add([
        expense.amount.toString(),
        expense.desc,
        expense.date.toString(),
      ]);
    }

    var csv = Csv(
      path: destFile,
      rows: rows,
    );

    csv.write();

    return true;
  }

  Future<bool> importDatabase() async {
    var result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var csvPath = result.files.first.path!;

      var csv = Csv.read(csvPath);

      var extExpenses = csv.rows
          .map(
            (row) => Expense(
              amount: double.parse(row[0]),
              desc: row[1],
              date: DateTime.parse(row[2]),
            ),
          )
          .toList();

      db.createAll(extExpenses);

      return true;
    }

    return false;
  }

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
                  var res = await exportDatabase();

                  if (context.mounted && res) {
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
                  var res = await importDatabase();

                  if (context.mounted && res) {
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
