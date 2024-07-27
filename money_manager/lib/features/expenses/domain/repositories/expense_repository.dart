import 'package:fpdart/fpdart.dart';
import 'package:money_manager/features/expenses/domain/entities/expense.dart';

abstract class ExpenseRepository {
  Future<Either<Exception, List<Expense>>> getAllExpenses();
  Future<Either<Exception, void>> addExpense(Expense expense);
  Future<Either<Exception, void>> updateExpense(Expense expense);
  Future<Either<Exception, void>> deleteExpense(Expense expense);
}
