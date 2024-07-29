part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

final class LoadExpensesEvent extends ExpenseEvent {}

final class AddExpenseEvent extends ExpenseEvent {
  final Expense expense;

  const AddExpenseEvent(this.expense);
}

final class UpdateExpenseEvent extends ExpenseEvent {
  final Expense expense;

  const UpdateExpenseEvent(this.expense);
}

final class DeleteExpenseEvent extends ExpenseEvent {
  final int id;

  const DeleteExpenseEvent(this.id);
}
