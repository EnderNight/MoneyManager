import 'package:fpdart/fpdart.dart';
import 'package:money_manager/features/expenses/domain/entities/expense.dart';
import 'package:money_manager/features/expenses/domain/repositories/expense_repository.dart';

class DeleteExpense {
  final ExpenseRepository repository;

  const DeleteExpense({required this.repository});

  Future<Either<Exception, void>> call(Expense expense) async {
    return await repository.deleteExpense(expense);
  }
}
