import 'package:fpdart/fpdart.dart';
import 'package:money_manager/features/expenses/domain/entities/expense.dart';
import 'package:money_manager/features/expenses/domain/repositories/expense_repository.dart';

class UpdateExpense {
  final ExpenseRepository repository;

  const UpdateExpense({required this.repository});

  Future<Either<Exception, void>> call(Expense expense) async {
    return await repository.updateExpense(expense);
  }
}
