// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_list_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpenseListScreenModel on _ExpenseListScreenModel, Store {
  late final _$expensesAtom =
      Atom(name: '_ExpenseListScreenModel.expenses', context: context);

  @override
  List<Expense> get expenses {
    _$expensesAtom.reportRead();
    return super.expenses;
  }

  @override
  set expenses(List<Expense> value) {
    _$expensesAtom.reportWrite(value, super.expenses, () {
      super.expenses = value;
    });
  }

  late final _$_ExpenseListScreenModelActionController =
      ActionController(name: '_ExpenseListScreenModel', context: context);

  @override
  void setExpenses(List<Expense> expenses) {
    final _$actionInfo = _$_ExpenseListScreenModelActionController.startAction(
        name: '_ExpenseListScreenModel.setExpenses');
    try {
      return super.setExpenses(expenses);
    } finally {
      _$_ExpenseListScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
expenses: ${expenses}
    ''';
  }
}
