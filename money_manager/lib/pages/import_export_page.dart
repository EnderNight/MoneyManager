import 'package:money_manager/core/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/data/database.dart';

class ImportExportPage extends StatelessWidget {
  final Database db;

  const ImportExportPage({
    super.key,
    required this.db,
  });

  Future<bool> exportDatabase() async {
    var expenses = db.get();
    var userDirectory = await FilePicker.platform.getDirectoryPath();

    if (userDirectory == null) return false;

    List<List<String>> rows = [];

    for (final expense in expenses) {
      rows.add([
        expense.amount.toString(),
        expense.desc,
        expense.date.toString(),
      ]);
    }

    var csv = Csv(path: '$userDirectory/expenses.csv', rows: rows);

    csv.write();

    return true;
  }

  Future<bool> importDatabase() async {
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
