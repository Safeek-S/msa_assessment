import 'package:mobx/mobx.dart';

import '../../database/database_helper.dart';
import '../../helpers/global_state/expense_store.dart';
import '../../model/expense_model.dart';
import '../../services/platform_services/local_storage_service/local_storage_service.dart';

part 'stats_screen_model.g.dart';
class StatsScreenModel extends _StatsScreenModel with _$StatsScreenModel {}

abstract class _StatsScreenModel with Store {
  
  @observable
  ObservableList<Expense> sortedExpenses = ObservableList<Expense>();

  @observable
   String selectedSortFeature = "Newest";
  final ExpenseStore expenseStore = ExpenseStore();
  LocalStorageService localStorageService = LocalStorageService(DatabaseHelper());


  @action 
  void setSelectedSortFeature(String feature){
    selectedSortFeature = feature;
  }

  @action 
  void setSortExpenses(ObservableList<Expense> expenses){
    sortedExpenses = expenses;
  }
}
