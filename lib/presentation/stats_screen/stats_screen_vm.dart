import 'package:mobx/mobx.dart';
import 'package:msa_assessment/model/expense_model.dart';
import 'package:msa_assessment/presentation/stats_screen/stats_screen_model.dart';

class StatsScreenVM extends StatsScreenModel {
  Future<void> fetchExpenses() async {
    try {
      var res = await localStorageService.getExpenses();
      expenseStore.setExpenses(ObservableList.of(res.data!));
      setSortExpenses(expenseStore.expenses);
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

  void sortExpense(String sortFeature) {
    try {
      switch (sortFeature) {
        case 'Newest':
          sortedExpenses.sortByDateDescending();
          setSortExpenses(sortedExpenses);

          break;
        case 'Oldest':
          sortedExpenses.sortByDateAscending();
          expenseStore.setExpenses(sortedExpenses);
          break;
        case 'High to Low':
          sortedExpenses.sortHighToLow();
          expenseStore.setExpenses(sortedExpenses);
          break;
        case 'Low to High':
          sortedExpenses.sortLowToHigh();
          setSortExpenses(sortedExpenses);
          break;
        default:
          sortedExpenses;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
