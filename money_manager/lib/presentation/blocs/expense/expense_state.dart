part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitialState extends ExpenseState {}

final class ExpenseLoadingState extends ExpenseState {}

final class ExpenseLoadedState extends ExpenseState {
  final List<Expense> expenses;

  const ExpenseLoadedState(this.expenses);
}
