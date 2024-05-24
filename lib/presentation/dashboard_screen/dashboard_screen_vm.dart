import 'package:mobx/mobx.dart';
import 'package:msa_assessment/presentation/dashboard_screen/dashboard_screen_model.dart';

class DashboardScreenVM extends DashboardScreenModel{

  Future<void> displayExpenses()async{
    try {
      var res = await localStorageService.getExpenses();
      expenseStore.setExpenses(ObservableList.of(res.data!));
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