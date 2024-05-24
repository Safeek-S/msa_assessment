import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:msa_assessment/helpers/app_navigation/app_routes.dart';
import 'package:msa_assessment/model/expense_model.dart';
import 'package:msa_assessment/presentation/dashboard_screen/dashboard_screen_vm.dart';
import 'package:msa_assessment/presentation/widgets/expense_list/expense_list.dart';
import 'package:msa_assessment/presentation/widgets/no_expenses/no_expenses.dart';
import 'package:msa_assessment/presentation/widgets/section_header/section_header.dart';

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
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6200EE),
        shape: const CircleBorder(),
        onPressed: () async {
          var expenses = await Navigator.pushNamed(
              context, AppRoute.addExpenseScreen.routeName,
              arguments: ['Add', null]) as List<Expense>;
          vm.expenseStore.setExpenses(ObservableList.of(expenses));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return vm.expenseStore.expenses.isEmpty
              ? SizedBox(
                height: height,
                child: noExpense(context))
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('d MMMM, y').format(DateTime.now()),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.015, bottom: height * 0.015),
                        padding: EdgeInsets.only(
                          top: height * 0.015,
                          bottom: height * 0.015,
                          left: width * 0.015,
                        ),
                        width: width,
                        height: height * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            end: Alignment.topCenter,
                            colors: [Color(0xff6200EE), Color(0xff9268CE)],
                          ),
                        ),
                        child: Observer(builder: (context) {
                          return RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Your Expense \n \n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Rs.${vm.expenseStore.totalExpense}',
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildSectionHeader('Recent Transactions', 18),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffEEE5FF)),
                            onPressed: () async {
                              var expenses = await Navigator.pushNamed(
                                  context, AppRoute.expenseListScreen.routeName,
                                  arguments: [
                                    vm.expenseStore.expenses
                                  ]) as List<Expense>;
                              vm.expenseStore
                                  .setExpenses(ObservableList.of(expenses));
                            },
                            child: const Text(
                              'See All',
                              style: TextStyle(color: Color(0xff7F3DFF)),
                            ),
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
                );
        }),
      ),
    );
  }
}
