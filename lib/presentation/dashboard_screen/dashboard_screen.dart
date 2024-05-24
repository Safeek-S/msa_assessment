import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:msa_assessment/helpers/app_navigation/app_routes.dart';
import 'package:msa_assessment/model/transaction_model.dart';
import 'package:msa_assessment/presentation/dashboard_screen/dashboard_screen_vm.dart';
import 'package:msa_assessment/presentation/widgets/expense_list/expense_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen();

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardScreenVM vm = DashboardScreenVM();
  @override
  void initState() {
    super.initState();
    vm.displayExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var expenses = await Navigator.pushNamed(
              context, AppRoute.addExpenseScreen.routeName,
              arguments: ['Add', null]) as List<Expense>;
          print(expenses.length);
          vm.expenseStore.setExpenses(ObservableList.of(expenses));
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              DateFormat('d MMMM, y').format(DateTime.now()),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              width: 400,
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff6200EE), Color(0xff9268CE)],
                ),
              ),
              child: Observer(builder: (context) {
                return Text(
                  'Your Expense Rs.${vm.expenseStore.totalExpense}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions'),
                ElevatedButton(
                  onPressed: () async {
                    var expenses = await Navigator.pushNamed(
                        context, AppRoute.expenseListScreen.routeName,
                        arguments: [vm.expenseStore.expenses]) as List<Expense>;
                    vm.expenseStore.setExpenses(ObservableList.of(expenses));
                  },
                  child: Text('View All'),
                ),
              ],
            ),
            Observer(builder: (context) {
              vm.expenseStore.expenses.sortByDateDescending();

              return vm.expenseStore.expenses.isNotEmpty
                  ? buildExpensesList(vm.expenseStore.expenses, vm)
                  : const Text('Add Expenses');
            }),
          ],
        ),
      ),
    );
  }
}
