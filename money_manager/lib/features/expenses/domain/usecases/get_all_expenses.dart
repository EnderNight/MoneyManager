import 'package:fpdart/fpdart.dart';
import 'package:money_manager/features/expenses/domain/entities/expense.dart';
import 'package:money_manager/features/expenses/domain/repositories/expense_repository.dart';

class GetAllExpenses {
  final ExpenseRepository repository;

  const GetAllExpenses({required this.repository});

  Future<Either<Exception, List<Expense>>> call(Expense expense) async {
    return await repository.getAllExpenses();
  }
}
