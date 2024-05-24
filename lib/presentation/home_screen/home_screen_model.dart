import 'package:mobx/mobx.dart';

import '../../database/database_helper.dart';
import '../../helpers/global_state/expense_store.dart';
import '../../services/platform_services/local_storage_service/local_storage_service.dart';
part 'home_screen_model.g.dart';
class HomeScreenModel extends _HomeScreenModel with _$HomeScreenModel {}

abstract class _HomeScreenModel with Store {
  final ExpenseStore expenseStore = ExpenseStore();
  LocalStorageService localStorageService = LocalStorageService(DatabaseHelper());
}
