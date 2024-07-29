import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/presentation/blocs/expense/expense_bloc.dart';
import 'package:money_manager/presentation/pages/add_expense_page.dart';
import 'package:money_manager/presentation/pages/edit_expense_page.dart';
import 'package:money_manager/presentation/widgets/expense_card.dart';
import 'package:money_manager/presentation/pages/import_export_page.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ImportExportPage())),
            icon: const Icon(Icons.import_export),
          ),
        ],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoadedState) {
            final expenses = state.expenses;

            if (expenses.isEmpty) {
              return const Center(
                child:
                    Text('No expenses. Click the add button to add a new one.'),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ExpenseCard(
                    expense: expenses[index],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditExpensePage(
                            expense: expenses[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const Center(child: Text('Unreachable state'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddExpensePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
