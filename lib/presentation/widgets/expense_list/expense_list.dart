  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../helpers/app_navigation/app_routes.dart';
import '../../../model/transaction_model.dart';
import '../../dashboard_screen/dashboard_screen_vm.dart';
import '../../expense_list_screen/expense_list_screen_vm.dart';

Widget buildExpensesList(List<Expense> expenses, Object vm) {
    return expenses.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: ValueKey(expenses[index].id),
                onDismissed: (direction) async {
                  if (vm is DashboardScreenVM) {
                    await Future.wait([
                      vm.deleteExpense(expenses[index].id!),
                      vm.displayExpenses()
                    ]);
                  } else if (vm is ExpenseListScreenVM) {
                    await Future.wait([
                      vm.deleteExpense(expenses[index].id!),
                      vm.displayExpenses()
                    ]);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('dismissed')),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  onTap: () async {
                    var expensesData = await Navigator.pushNamed(
                            context, AppRoute.addExpenseScreen.routeName,
                            arguments: ['Update', expenses[index]])
                        as List<Expense>;
                    print(expensesData.length);
                    if (vm is ExpenseListScreenVM) {
                      vm.setExpenses(expensesData);
                    } else if (vm is DashboardScreenVM) {
                      vm.expenseStore.setExpenses(ObservableList.of(expensesData));
                    }
                    ;
                  },
                  title: Text(expenses[index].category.name),
                  subtitle: Text(DateFormat('d MMMM, y')
                      .format(expenses[index].createdAt)),
                  trailing: Text('Rs. ${expenses[index].amount}'),
                ),
              );
            },
          )
        : const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No expenses found.'),
          );
  }