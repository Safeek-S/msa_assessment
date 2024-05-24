import 'package:mobx/mobx.dart';

import '../../model/expense_model.dart';

part 'expense_store.g.dart';
class ExpenseStore = _ExpenseStore with _$ExpenseStore;

abstract class _ExpenseStore with Store {
  @observable
  ObservableList<Expense> expenses = ObservableList<Expense>();

   @computed
  double get totalExpense => expenses.fold(0, (sum, expense) => sum + expense.amount);

 
  @action
  void setExpenses(ObservableList<Expense> expenses)  {
    this.expenses = expenses;
   
  }

    @computed
  List<String> get categories {
    Set<String> categorySet = {};
    for (var expense in expenses) {
      categorySet.add(expense.category.name);
    }
    return categorySet.toList();
  }

@computed
Map<String, double> get categoryTotals {
  Map<String, double> categoryTotals = {};
  for (var expense in expenses) {
    String categoryName = expense.category.name;
    double amount = expense.amount;
    if (categoryTotals.containsKey(categoryName)) {
      categoryTotals[categoryName] = categoryTotals[categoryName]! + amount;
    } else {
      categoryTotals[categoryName] = amount;
    }
  }
  return categoryTotals;
}

}