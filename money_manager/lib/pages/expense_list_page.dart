import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/data/database.dart';
import 'package:money_manager/data/expense.dart';
import 'package:money_manager/pages/expense_page.dart';
import 'package:money_manager/pages/import_export_page.dart';
import 'package:money_manager/widgets/expense_widget.dart';

class ExpenseListPage extends StatefulWidget {
  final db = Database();

  ExpenseListPage({super.key});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  late List<Expense> expenses;
  bool deleteMode = false;
  int selectedExpense = -1;

  void addExpense(Expense expense) {
    widget.db.create(expense);

    setState(() {
      expenses = widget.db.get();
    });
  }

  void updateExpense(Expense expense, int index) {
    widget.db.update(expense, index);

    setState(() {
      expenses = widget.db.get();
    });
  }

  void deleteExpense() {
    if (selectedExpense == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No expenses selected (error)'),
        ),
      );

      setState(() {
        deleteMode = false;
      });

      return;
    }

    widget.db.delete(selectedExpense);

    setState(() {
      selectedExpense = -1;
      deleteMode = false;
      expenses = widget.db.get();
    });
  }

  @override
  void initState() {
    super.initState();

    expenses = widget.db.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: deleteMode
            ? [
                IconButton(
                  onPressed: deleteExpense,
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      deleteMode = false;
                      selectedExpense = -1;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
              ]
            : [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImportExportPage(
                          db: widget.db,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.import_export),
                ),
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: _ExpenseStatusWidget(
                expenseTotal: widget.db.getExpenseTotal(),
                incomeTotal: widget.db.getIncomeTotal(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) => ExpenseWidget(
                  expense: expenses[index],
                  onTap: () async {
                    Expense? expense =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ExpensePage(
                        pageTitle: 'Update expense',
                        buttonText: 'Save',
                        expense: expenses[index],
                      ),
                    ));

                    if (expense == null) return;

                    updateExpense(expense, index);
                  },
                  onLongPress: () {
                    setState(() {
                      deleteMode = true;
                      selectedExpense = index;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Expense? expense = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ExpensePage(
              pageTitle: 'Add expense',
              expense: null,
              buttonText: 'Add',
            ),
          ));

          if (expense == null) return;

          addExpense(expense);
        },
        tooltip: 'Add a new expense',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ExpenseStatusWidget extends StatelessWidget {
  final double expenseTotal;
  final double incomeTotal;
  final amountFormat = NumberFormat.compactCurrency(
    symbol: '€',
    decimalDigits: 2,
  );

  _ExpenseStatusWidget({
    required this.expenseTotal,
    required this.incomeTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            amountFormat.format(expenseTotal + incomeTotal),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Income: ${amountFormat.format(incomeTotal)}'),
            Text('Expenses: ${amountFormat.format(expenseTotal)}'),
          ],
        )
      ],
    );
  }
}
