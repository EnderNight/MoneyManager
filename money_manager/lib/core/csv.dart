import 'dart:io';

class Csv {
  final String path;
  final List<List<String>> rows;

  const Csv({
    required this.path,
    required this.rows,
  });

  factory Csv.read(String path) {
    var file = File(path);

    if (!file.existsSync()) throw FileSystemException('$path not found');

    var lines = file.readAsLinesSync();
    List<List<String>> rows = [];

    for (final line in lines) {
      var tokens = line.split(",");

      rows.add(tokens);
    }

    return Csv(path: path, rows: rows);
  }

  void addRow(List<String> row) {
    rows.add(row);
  }

  void write() {
    var file = File(path);

    var res = '';

    for (final row in rows) {
      res += '${row.join(',')}\n';
    }

    file.writeAsStringSync(res);
  }
}
