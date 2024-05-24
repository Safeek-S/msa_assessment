import 'package:msa_assessment/presentation/expense_list_screen/expense_list_screen_model.dart';

class ExpenseListScreenVM extends ExpenseListScreenModel{

  Future<void> displayExpenses()async{
    try {
      var res = await localStorageService.getExpenses();
      setExpenses(res.data!);
    } catch (e) {
      print(e.toString());
    }
  }
  
  Future<void> deleteExpense(String id)async{
    try {
      var res = await localStorageService.deleteExpense(id);
      print(res.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }
}