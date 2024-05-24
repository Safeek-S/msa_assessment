import 'package:msa_assessment/model/expense_model.dart';

import '../../../database/database_helper.dart';
import '../../../helpers/service_result.dart';

class LocalStorageService {
  final DatabaseHelper databaseHelper;
  LocalStorageService(this.databaseHelper);

  Future<ServiceResult<List<Expense>?>> getExpenses() async {
    try {
      final db = await databaseHelper.getDatabase();
      final List<Map<String, dynamic>> expenseData = await db.query('Expenses');
      var expenses = List.generate(
          expenseData.length, (i) => Expense.fromJson(expenseData[i]));
      if (expenses.isNotEmpty) {
        return ServiceResult(StatusCode.success, "Expenses fetched", expenses);
      } else {
        return ServiceResult(StatusCode.failure, 'No Expenses found', []);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), []);
    }
  }

  Future<ServiceResult<int>> createExpense(Expense expense) async {
    try {
      final db = await databaseHelper.database;
      var res = await db.insert('Expenses', expense.toJson());
      return ServiceResult(StatusCode.success, 'Created a Expense', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<int>> updateExpense(Expense expense) async {
    try {
      final db = await databaseHelper.getDatabase();
      var res = await db.update(
        'Expenses',
        expense.toJson(),
        where: 'id = ?',
        whereArgs: [expense.id],
      );
      return ServiceResult(StatusCode.success, 'Expense updated', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<int>> deleteExpense(String id) async {
    try {
      final db = await databaseHelper.getDatabase();
      var res = await db.delete(
        'Expenses',
        where: 'id = ?',
        whereArgs: [id],
      );
      return ServiceResult(StatusCode.success, 'Expense deleted', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }
}
