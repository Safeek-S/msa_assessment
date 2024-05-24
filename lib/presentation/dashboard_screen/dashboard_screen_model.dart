import 'package:mobx/mobx.dart';
import 'package:msa_assessment/database/database_helper.dart';
import 'package:msa_assessment/helpers/global_state/expense_store.dart';

import '../../services/platform_services/local_storage_service/local_storage_service.dart';
part 'dashboard_screen_model.g.dart';

class DashboardScreenModel extends _DashboardScreenModel
    with _$DashboardScreenModel {}

abstract class _DashboardScreenModel with Store {
  final ExpenseStore expenseStore = ExpenseStore();
  LocalStorageService localStorageService = LocalStorageService(DatabaseHelper());
}
