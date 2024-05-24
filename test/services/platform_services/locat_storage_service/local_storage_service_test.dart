import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:msa_assessment/database/database_helper.dart';
import 'package:msa_assessment/helpers/service_result.dart';
import 'package:msa_assessment/model/transaction_model.dart';
import 'package:mockito/mockito.dart';
import 'package:msa_assessment/utils/utlils.dart';
import 'package:msa_assessment/services/platform_services/local_storage_service/local_storage_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'local_storage_service_test.mocks.dart';

@GenerateMocks([ Expense, DatabaseHelper])
void main() {
   sqfliteFfiInit();
 Database db;
   MockDatabaseHelper databaseHelper = MockDatabaseHelper();
   LocalStorageService localStorageService = LocalStorageService(databaseHelper);
  setUpAll(() async{
     db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.execute('''
        CREATE TABLE Expenses (
        id TEXT PRIMARY KEY,
        userID TEXT NOT NULL,
        amount REAL NOT NULL,
        createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        category TEXT NOT NULL,
        description TEXT,
        isDeleted INTEGER NOT NULL DEFAULT 0
        )
      ''');
    localStorageService;
  });

  group('Database Test -', () {
    Expense expense = Expense(amount: 100, category: ExpenseCategory.food, userID: "user-12", createdAt: DateTime.now(),description: 'kkkk');
    var data = expense.toJson();
    setUp(() {
      data;
      expense;
    });
    test('adding expense sucessfully', () async {
      //  final mockDatabase = await MockDatabaseHelper().database;
      when( databaseHelper.database).thenAnswer((_)=> Future.value(db));
      when( db.insert('Expenses', data)).thenAnswer((realInvocation) async=> 1);
      var res = await localStorageService.createExpense(expense);
      expect(res.statusCode,StatusCode.success);
      expect(res.data, 1);
    });
  });
}
