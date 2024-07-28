import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_manager/features/expenses/data/models/expense.dart';
import 'package:money_manager/features/expenses/data/repositories/expense_repository.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository repository;

  ExpenseBloc({required this.repository}) : super(ExpenseInitialState()) {
    on<LoadExpensesEvent>(_loadExpenses);
    on<AddExpenseEvent>(_addExpense);
    on<UpdateExpenseEvent>(_updateExpense);
    on<DeleteExpenseEvent>(_deleteExpense);
  }

  Future<void> _loadExpenses(
      LoadExpensesEvent event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoadingState());

    final expenses = await repository.getExpenses();
    emit(ExpenseLoadedState(expenses));
  }

  void _addExpense(AddExpenseEvent event, Emitter<ExpenseState> emit) async {
    await repository.addExpense(event.expense);

    add(LoadExpensesEvent());
  }

  void _updateExpense(
      UpdateExpenseEvent event, Emitter<ExpenseState> emit) async {
    await repository.updateExpense(event.expense);

    add(LoadExpensesEvent());
  }

  void _deleteExpense(
      DeleteExpenseEvent event, Emitter<ExpenseState> emit) async {
    await repository.deleteExpense(event.id);

    add(LoadExpensesEvent());
  }
}
