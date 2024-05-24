// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_chart_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PieChartModel on _PieChartModel, Store {
  late final _$touchIndexAtom =
      Atom(name: '_PieChartModel.touchIndex', context: context);

  @override
  int get touchIndex {
    _$touchIndexAtom.reportRead();
    return super.touchIndex;
  }

  @override
  set touchIndex(int value) {
    _$touchIndexAtom.reportWrite(value, super.touchIndex, () {
      super.touchIndex = value;
    });
  }

  late final _$_PieChartModelActionController =
      ActionController(name: '_PieChartModel', context: context);

  @override
  void setTouchIndex(int index) {
    final _$actionInfo = _$_PieChartModelActionController.startAction(
        name: '_PieChartModel.setTouchIndex');
    try {
      return super.setTouchIndex(index);
    } finally {
      _$_PieChartModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
touchIndex: ${touchIndex}
    ''';
  }
}
