import 'package:fpdart/fpdart.dart';
import 'package:money_manager/features/expenses/data/datasources/expense_data_source.dart';
import 'package:money_manager/features/expenses/data/models/expense_model.dart';
import 'package:money_manager/features/expenses/domain/entities/expense.dart';
import 'package:money_manager/features/expenses/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  final ExpenseDataSource expenseDataSource;

  ExpenseRepositoryImpl({required this.expenseDataSource});

  @override
  Future<Either<Exception, void>> addExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      await expenseDataSource.addExpense(expenseModel);

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> deleteExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      await expenseDataSource.addExpense(expenseModel);

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<Expense>>> getAllExpenses() async {
    try {
      final expenses = await expenseDataSource.getAllExpenses();

      return Right(expenses.map((e) => e.toEntity()).toList());
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> updateExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      await expenseDataSource.addExpense(expenseModel);

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
