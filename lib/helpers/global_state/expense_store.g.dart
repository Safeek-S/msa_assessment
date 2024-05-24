// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpenseStore on _ExpenseStore, Store {
  Computed<double>? _$totalExpenseComputed;

  @override
  double get totalExpense =>
      (_$totalExpenseComputed ??= Computed<double>(() => super.totalExpense,
              name: '_ExpenseStore.totalExpense'))
          .value;
  Computed<List<String>>? _$categoriesComputed;

  @override
  List<String> get categories =>
      (_$categoriesComputed ??= Computed<List<String>>(() => super.categories,
              name: '_ExpenseStore.categories'))
          .value;
  Computed<Map<String, double>>? _$categoryTotalsComputed;

  @override
  Map<String, double> get categoryTotals => (_$categoryTotalsComputed ??=
          Computed<Map<String, double>>(() => super.categoryTotals,
              name: '_ExpenseStore.categoryTotals'))
      .value;

  late final _$expensesAtom =
      Atom(name: '_ExpenseStore.expenses', context: context);

  @override
  ObservableList<Expense> get expenses {
    _$expensesAtom.reportRead();
    return super.expenses;
  }

  @override
  set expenses(ObservableList<Expense> value) {
    _$expensesAtom.reportWrite(value, super.expenses, () {
      super.expenses = value;
    });
  }

  late final _$_ExpenseStoreActionController =
      ActionController(name: '_ExpenseStore', context: context);

  @override
  void setExpenses(ObservableList<Expense> expenses) {
    final _$actionInfo = _$_ExpenseStoreActionController.startAction(
        name: '_ExpenseStore.setExpenses');
    try {
      return super.setExpenses(expenses);
    } finally {
      _$_ExpenseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
expenses: ${expenses},
totalExpense: ${totalExpense},
categories: ${categories},
categoryTotals: ${categoryTotals}
    ''';
  }
}
