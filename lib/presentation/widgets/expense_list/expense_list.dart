  import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:msa_assessment/presentation/stats_screen/stats_screen_vm.dart';

import '../../../helpers/app_navigation/app_routes.dart';
import '../../../model/expense_model.dart';
import '../../../utils/utlils.dart';
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
                  }else if(vm is StatsScreenVM){
                      await Future.wait([
                      vm.deleteExpense(expenses[index].id!),
                      vm.fetchExpenses()
                    ]);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('dismissed')),
                  );
                },
                background: Container(
                  padding: EdgeInsets.only(right: 14),
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(),
                  onTap: () async {
                    var expensesData = await Navigator.pushNamed(
                            context, AppRoute.addExpenseScreen.routeName,
                            arguments: ['Update', expenses[index]])
                        as List<Expense>;
                  
                    if (vm is ExpenseListScreenVM) {
                      vm.setExpenses(expensesData);
                    } else if (vm is DashboardScreenVM) {
                      vm.expenseStore.setExpenses(ObservableList.of(expensesData));
                    }else if(vm is StatsScreenVM){
                      vm.setSortExpenses(ObservableList.of(expensesData));
                    }
                    ;
                  },
                  leading: Container(
                    width: 60,
                    height: 60,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: getColorBasedOnCategory(expenses[index].category,''),
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 5,vertical:10 ),
                    child: Center(child: getIconBasedOnCategory(expenses[index].category)),
                  ),
                  title: Text(expenses[index].category.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(expenses[index].description!,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16),),
                  trailing: Text('Rs.${expenses[index].amount}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              );
            },
          )
        : const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No expenses found.'),
          );
  }