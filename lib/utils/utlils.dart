import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum ExpenseCategory{
  food('Food'),
  shopping('Shopping'),
  travel('Travel');

  const ExpenseCategory(this.name);
  final String name;

}

String generateUuid({required String code}) {
  Uuid uuid = const Uuid();
  return '$code-${uuid.v4()}';
}



Color getColorBasedOnCategory(ExpenseCategory category, String widgetType) {
  switch (category) {
    case ExpenseCategory.shopping:
      return widgetType.toLowerCase() == 'icon' ? Color(0xffFCAC12) : Color(0xffFCEED4);
    case ExpenseCategory.food:
      return widgetType.toLowerCase() == 'icon' ? Color(0xffFD3C4A) : Color(0xffFDD5D7);
    case ExpenseCategory.travel:
      return widgetType.toLowerCase() == 'icon' ? Color(0xff7F3DFF) : Color(0xffEEE5FF);
    default:
      return widgetType.toLowerCase() == 'icon' ? Colors.grey : Colors.grey[200]!;
  }
}

Icon getIconBasedOnCategory(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.food:
      return Icon(Icons.fastfood, color: getColorBasedOnCategory(category, 'icon'));
    case ExpenseCategory.travel:
      return Icon(Icons.emoji_transportation, color: getColorBasedOnCategory(category, 'icon'));
    case ExpenseCategory.shopping:
      return Icon(Icons.shopping_cart,color: getColorBasedOnCategory(category, 'icon'),);
    default:
      return Icon(Icons.category, color: Colors.grey);
  }
}


 Color getColorForCategory(int index) {
    const List<Color> categoryColors = [
      Color(0xFF50E4FF), // Cyan
      Color(0xFFFFC300), // Yellow
      Color(0xFFFF683B), // Orange
      Color(0xFF3BFF49), // Green
      Color(0xFF6E1BFF), // Purple
    ];
    return categoryColors[index % categoryColors.length];
  }

  List<Color> _generateColors(int count) {
    final List<Color> colors = [];
    final Random random = Random();
    for (int i = 0; i < count; i++) {
      final color = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
      colors.add(color);
    }
    return colors;
  }