import 'dart:io';

import 'package:money_manager/core/utils/date_formatter.dart';
import 'package:money_manager/data/models/expense.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ExpenseCsv {
  static List<Expense> read(String filePath) {
    final file = File(filePath);

    if (!file.existsSync()) {
      throw FileSystemException('$filePath: file not found');
    }

    final lines = file.readAsLinesSync();
    final expenses = <Expense>[];

    for (final line in lines) {
      final tokens = line.split(",");

      expenses.add(Expense(
        id: -1,
        amount: double.parse(tokens[0]),
        desc: tokens[1],
        date: DateTime.parse(tokens[2]),
      ));
    }

    return expenses;
  }

  static Future<void> write(
      List<Expense> expenses, String directoryPath) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final filePath =
        '$directoryPath/expenses_${formatDate(DateTime.now())}_v${packageInfo.version}.csv';

    final file = File(filePath);
    String csvStr = "";

    for (final expense in expenses) {
      csvStr += '${[
        expense.amount.toStringAsFixed(2),
        expense.desc,
        expense.date,
      ].join(",")}\n';
    }

    file.writeAsStringSync(csvStr);
  }
}
