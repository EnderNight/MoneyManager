import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:money_manager/data/models/expense.dart';

class NetworkService {
  Future<List<Expense>> syncExpenses(
      List<Expense> expenses, String authority) async {
    final toSend = expenses
        .where((expense) => expense.isLocal)
        .map((expense) => expense.toJson())
        .toList();
    final apiUrl = Uri.http("$authority:5000", "/api/expenses");

    await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: convert.jsonEncode(toSend),
    );

    return await _fetchExpenses(authority);
  }

  Future<List<Expense>> _fetchExpenses(String authority) async {
    final apiUrl = Uri.http("$authority:5000", "/api/expenses");

    var response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      var jsonExpenses = convert.jsonDecode(response.body) as List<dynamic>;

      return jsonExpenses
          .map((jsonExpense) => Expense.fromJson(jsonExpense))
          .toList();
    }

    return [];
  }
}
