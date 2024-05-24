import 'package:mobx/mobx.dart';

import '../../database/database_helper.dart';
import '../../helpers/global_state/expense_store.dart';
import '../../model/expense_model.dart';
import '../../services/platform_services/local_storage_service/local_storage_service.dart';

part 'expense_list_screen_model.g.dart';

class ExpenseListScreenModel extends _ExpenseListScreenModel
    with _$ExpenseListScreenModel {}

abstract class _ExpenseListScreenModel with Store {

  @observable
  List<Expense> expenses = [];


  final ExpenseStore expenseStore = ExpenseStore();
  LocalStorageService localStorageService = LocalStorageService(DatabaseHelper());


  @action
  void setExpenses(List<Expense> expenses){
    this.expenses = expenses;
  }
}
