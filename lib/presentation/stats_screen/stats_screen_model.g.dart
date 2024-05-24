// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatsScreenModel on _StatsScreenModel, Store {
  late final _$sortedExpensesAtom =
      Atom(name: '_StatsScreenModel.sortedExpenses', context: context);

  @override
  ObservableList<Expense> get sortedExpenses {
    _$sortedExpensesAtom.reportRead();
    return super.sortedExpenses;
  }

  @override
  set sortedExpenses(ObservableList<Expense> value) {
    _$sortedExpensesAtom.reportWrite(value, super.sortedExpenses, () {
      super.sortedExpenses = value;
    });
  }

  late final _$selectedSortFeatureAtom =
      Atom(name: '_StatsScreenModel.selectedSortFeature', context: context);

  @override
  String get selectedSortFeature {
    _$selectedSortFeatureAtom.reportRead();
    return super.selectedSortFeature;
  }

  @override
  set selectedSortFeature(String value) {
    _$selectedSortFeatureAtom.reportWrite(value, super.selectedSortFeature, () {
      super.selectedSortFeature = value;
    });
  }

  late final _$_StatsScreenModelActionController =
      ActionController(name: '_StatsScreenModel', context: context);

  @override
  void setSelectedSortFeature(String feature) {
    final _$actionInfo = _$_StatsScreenModelActionController.startAction(
        name: '_StatsScreenModel.setSelectedSortFeature');
    try {
      return super.setSelectedSortFeature(feature);
    } finally {
      _$_StatsScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortExpenses(ObservableList<Expense> expenses) {
    final _$actionInfo = _$_StatsScreenModelActionController.startAction(
        name: '_StatsScreenModel.setSortExpenses');
    try {
      return super.setSortExpenses(expenses);
    } finally {
      _$_StatsScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sortedExpenses: ${sortedExpenses},
selectedSortFeature: ${selectedSortFeature}
    ''';
  }
}
