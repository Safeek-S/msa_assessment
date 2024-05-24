

import '../utils/utlils.dart';

class Expense {
  String? id;
  String userID;
  ExpenseCategory category;
  double amount;
  DateTime createdAt;
  String? description;
  int isDeleted;

  Expense({
    this.id,
    required this.category,
    required this.userID,
    required this.amount,
    required this.createdAt,
    this.description,
    this.isDeleted = 0,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      userID: json['userID'],
      category:ExpenseCategory.values.firstWhere((e) => e.name == json['category']),
      amount: json['amount'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'amount': amount,
      'createdAt': createdAt.toIso8601String(),
      'description': description,
      'category': category.name,
      'isDeleted': isDeleted,
    };
  }
}

extension ExpenseListExtension on List<Expense> {
  // Sort by date in ascending order
  void sortByDateAscending() {
    sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  // Sort by date in descending order
  void sortByDateDescending() {
    sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

   void sortHighToLow() {
    sort((a, b) => b.amount.compareTo(a.amount));
  }

  void sortLowToHigh() {
    sort((a, b) => a.amount.compareTo(b.amount));
  }
  
  // Get transactions for the current week
  List<Expense> getTransactionsForCurrentWeek() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return where((expense) =>
        expense.createdAt.isAfter(startOfWeek) &&
        expense.createdAt.isBefore(now.add(Duration(days: 1)))).toList();
  }

  // Get transactions for past weeks
  List<Expense> getTransactionsForPastWeeks() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return where((expense) => expense.createdAt.isBefore(startOfWeek)).toList();
  }
}
