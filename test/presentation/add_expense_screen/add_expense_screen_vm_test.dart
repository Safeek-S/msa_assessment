import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:msa_assessment/database/database_helper.dart';
import 'package:msa_assessment/helpers/service_result.dart';
import 'package:msa_assessment/model/expense_model.dart';
import 'package:msa_assessment/presentation/add_expense_screen/add_expense_screen_vm.dart';
import 'package:msa_assessment/services/platform_services/local_storage_service/local_storage_service.dart';
import 'package:msa_assessment/utils/utlils.dart';
import 'package:sqflite/sqflite.dart';

import 'add_expense_screen_vm_test.mocks.dart';


@GenerateMocks([DatabaseHelper,Database])
void main(){
  MockDatabaseHelper databaseHelper = MockDatabaseHelper();
  AddExpenseScreenVM vm = AddExpenseScreenVM();
  LocalStorageService localStorageService = LocalStorageService(databaseHelper);
  group('addExpense', () {
    var expenseData = Expense(
          id: generateUuid(code: 'expense'),
          category: ExpenseCategory.food,
          userID: "user-12",
          description: "dsfwer",
          amount: double.parse("100"),
          createdAt: DateTime.now());

    setUp(() {
      expenseData;
    });
    test('success', () async{
       final mockDatabase = MockDatabase();
      when(databaseHelper.database)
          .thenAnswer((_) => Future.value(mockDatabase));
      when(mockDatabase.insert('Expenses', expenseData.toJson()))
          .thenAnswer((realInvocation) async => 1);
      when(localStorageService.createExpense(expenseData)).thenAnswer((realInvocation) => Future.value(ServiceResult(StatusCode.success, "", 1)));
      var res = await localStorageService.createExpense(expenseData);
      await vm.addExpense();
      verify(localStorageService.createExpense(expenseData)).called(1);

    });
   });

}