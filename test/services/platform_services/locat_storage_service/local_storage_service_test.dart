import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:msa_assessment/database/database_helper.dart';
import 'package:msa_assessment/helpers/service_result.dart';
import 'package:msa_assessment/model/expense_model.dart';
import 'package:mockito/mockito.dart';
import 'package:msa_assessment/utils/utlils.dart';
import 'package:msa_assessment/services/platform_services/local_storage_service/local_storage_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'local_storage_service_test.mocks.dart';

@GenerateMocks([Expense, DatabaseHelper, Database])
void main() {
  MockDatabaseHelper databaseHelper = MockDatabaseHelper();
  LocalStorageService localStorageService = LocalStorageService(databaseHelper);

  group('Database Test - Creating Expense', () {
    Expense inCompleteExpense = Expense(
        amount: 100,
        category: ExpenseCategory.food,
        userID: "",
        createdAt: DateTime.now(),
        description: 'kkkk');

    var inCompleteExpensedata = inCompleteExpense.toJson();
    Expense expense = Expense(
        amount: 100,
        category: ExpenseCategory.food,
        userID: "user-12",
        createdAt: DateTime.now(),
        description: 'kkkk');

    var data = expense.toJson();
    setUp(() {
      inCompleteExpense;
      inCompleteExpensedata;
      data;
      expense;
    });
    test('adding expense sucessfully', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.database)
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.insert('Expenses', data))
          .thenAnswer((realInvocation) async => 1);
      var res = await localStorageService.createExpense(expense);
      expect(res.statusCode, StatusCode.success);
      expect(res.data, 1);
    });
    test('adding expense was not successful', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.database)
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.insert('Expenses', inCompleteExpensedata))
          .thenAnswer((realInvocation) async => Future.error(-1));
      var res = await localStorageService.createExpense(inCompleteExpense);
      expect(res.statusCode, StatusCode.error);
      expect(res.data, -99);
    });
  });

  group('Database Test - Fetch Expenses', () {
    List<Expense> expenses = [
      Expense(
          amount: 100,
          category: ExpenseCategory.food,
          userID: "user-12",
          createdAt: DateTime.now(),
          description: 'kkkk'),
      Expense(
          amount: 100,
          category: ExpenseCategory.food,
          userID: "user-12",
          createdAt: DateTime.now(),
          description: 'kkkk')
    ];

    List<Map<String, dynamic>> expensesData =
        expenses.map((expense) => expense.toJson()).toList();
    var emptyExpenseData = [];

    setUp(() {
      expenses;
      expensesData;
      emptyExpenseData;
    });
    test('fetching expenses sucessfully', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.getDatabase())
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.query('Expenses'))
          .thenAnswer((realInvocation) async => expensesData);
      var res = await localStorageService.getExpenses();
      expect(res.statusCode, StatusCode.success);
      expect(res.data!.length, expenses.length);
    });
    test('fetching expenses was not successful', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.getDatabase())
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.query('Expenses'))
          .thenAnswer((realInvocation) async => Future.error([]));
      var res = await localStorageService.getExpenses();
      expect(res.statusCode, StatusCode.error);
      expect(res.data!.length, 0);
    });
  });

  group('Database Test - Update Expense', () {
    Expense expense = Expense(
        id: "expense-12234-3456",
        amount: 100,
        category: ExpenseCategory.food,
        userID: "user-12",
        createdAt: DateTime.now(),
        description: 'kkkk');

    Map<String, dynamic> expenseData = expense.toJson();

    Expense inCompleteExpense = Expense(
        id: "expense-12234",
        amount: 100,
        category: ExpenseCategory.food,
        userID: "",
        createdAt: DateTime.now(),
        description: 'kkkk');

    var inCompleteExpensedata = inCompleteExpense.toJson();
    inCompleteExpensedata["id"] = "expense-124";

    setUp(() {
      expense;
      expenseData;
      inCompleteExpense;
      inCompleteExpensedata;
    });
    test('Update expense sucessfully', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.getDatabase())
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.update(
        'Expenses',
        expenseData,
        where: 'id = ?',
        whereArgs: [expense.id],
      )).thenAnswer((realInvocation) async => 1);
      var res = await localStorageService.updateExpense(expense);
      expect(res.statusCode, StatusCode.success);
      expect(res.data, 1);
    });
    test('Update expense was not successful', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.getDatabase())
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.update(
        'Expenses',
        inCompleteExpensedata,
        where: 'id = ?',
        whereArgs: [inCompleteExpense.id],
      )).thenAnswer((realInvocation) async => Future.error(-99));
      var res = await localStorageService.updateExpense(inCompleteExpense);
      expect(res.statusCode, StatusCode.error);
      expect(res.data, -99);
    });
  });

  group('Database Test - Delete Expense', () {
    var id = "expense-12234";
    var incorrectId = "exp-";

    setUp(() {
      id;
      incorrectId;
    });
    test('delete expense sucessfully', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.getDatabase())
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.delete(
        'Expenses',
        where: 'id = ?',
        whereArgs: [id],
      )).thenAnswer((realInvocation) async => 1);
      var res = await localStorageService.deleteExpense(id);
      expect(res.statusCode, StatusCode.success);
      expect(res.data, 1);
    });
    test('delete expense was not successful', () async {
      final mockDatabase = MockDatabase();
      when(databaseHelper.getDatabase())
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.delete(
        'Expenses',
        where: 'id = ?',
        whereArgs: [incorrectId],
      )).thenAnswer((realInvocation) async => Future.error(-99));
      var res = await localStorageService.deleteExpense(incorrectId);
      expect(res.statusCode, StatusCode.error);
      expect(res.data, -99);
    });
  });
}
