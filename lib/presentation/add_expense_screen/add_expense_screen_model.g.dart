// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_expense_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddExpenseScreenModel on _AddExpenseScreenModel, Store {
  late final _$selectedCategoryAtom =
      Atom(name: '_AddExpenseScreenModel.selectedCategory', context: context);

  @override
  ExpenseCategory get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(ExpenseCategory value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$calculatedAmountAtom =
      Atom(name: '_AddExpenseScreenModel.calculatedAmount', context: context);

  @override
  String get calculatedAmount {
    _$calculatedAmountAtom.reportRead();
    return super.calculatedAmount;
  }

  @override
  set calculatedAmount(String value) {
    _$calculatedAmountAtom.reportWrite(value, super.calculatedAmount, () {
      super.calculatedAmount = value;
    });
  }

  late final _$formattedDateAtom =
      Atom(name: '_AddExpenseScreenModel.formattedDate', context: context);

  @override
  String get formattedDate {
    _$formattedDateAtom.reportRead();
    return super.formattedDate;
  }

  @override
  set formattedDate(String value) {
    _$formattedDateAtom.reportWrite(value, super.formattedDate, () {
      super.formattedDate = value;
    });
  }

  late final _$notesAtom =
      Atom(name: '_AddExpenseScreenModel.notes', context: context);

  @override
  String get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(String value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$_AddExpenseScreenModelActionController =
      ActionController(name: '_AddExpenseScreenModel', context: context);

  @override
  void setNotes(String notes) {
    final _$actionInfo = _$_AddExpenseScreenModelActionController.startAction(
        name: '_AddExpenseScreenModel.setNotes');
    try {
      return super.setNotes(notes);
    } finally {
      _$_AddExpenseScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFormattedDate(String date) {
    final _$actionInfo = _$_AddExpenseScreenModelActionController.startAction(
        name: '_AddExpenseScreenModel.setFormattedDate');
    try {
      return super.setFormattedDate(date);
    } finally {
      _$_AddExpenseScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCalculatedAmount(String amount) {
    final _$actionInfo = _$_AddExpenseScreenModelActionController.startAction(
        name: '_AddExpenseScreenModel.setCalculatedAmount');
    try {
      return super.setCalculatedAmount(amount);
    } finally {
      _$_AddExpenseScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpenseCategory(ExpenseCategory category) {
    final _$actionInfo = _$_AddExpenseScreenModelActionController.startAction(
        name: '_AddExpenseScreenModel.setExpenseCategory');
    try {
      return super.setExpenseCategory(category);
    } finally {
      _$_AddExpenseScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategory: ${selectedCategory},
calculatedAmount: ${calculatedAmount},
formattedDate: ${formattedDate},
notes: ${notes}
    ''';
  }
}
