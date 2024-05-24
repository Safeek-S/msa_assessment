import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:msa_assessment/database/database_helper.dart';

import '../../helpers/global_state/expense_store.dart';
import '../../model/expense_model.dart';
import '../../services/platform_services/local_storage_service/local_storage_service.dart';
import '../../utils/utlils.dart';
part 'add_expense_screen_model.g.dart';

class AddExpenseScreenModel extends _AddExpenseScreenModel
    with _$AddExpenseScreenModel {}

abstract class _AddExpenseScreenModel with Store {

  final ExpenseStore expenseStore = ExpenseStore();
  LocalStorageService localStorageService = LocalStorageService(DatabaseHelper());
  
DateTime selectedDate = DateTime.now();
Expense? expense;
  String equation = "0";
  String expression = "";
String operation = "Add";

  @observable
  ExpenseCategory selectedCategory = ExpenseCategory.food;

  @observable
  String calculatedAmount = "";

  @observable
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @observable
  String notes = "";

  @action
  void setNotes(String notes) {
    this.notes = notes;
  }

  @action
  void setFormattedDate(String date) {
    formattedDate = date;
  }

  @action
  void setCalculatedAmount(String amount) {
    calculatedAmount = amount;
  }

  @action
  void setExpenseCategory(ExpenseCategory category) {
    selectedCategory = category;
  }
}
