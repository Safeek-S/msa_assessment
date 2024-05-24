import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msa_assessment/presentation/stats_screen/stats_screen_vm.dart';
import 'package:msa_assessment/presentation/widgets/expense_list/expense_list.dart';
import 'package:msa_assessment/presentation/widgets/no_expenses/no_expenses.dart';
import 'package:msa_assessment/presentation/widgets/section_header/section_header.dart';

import '../widgets/pie_chart/pie_chart.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen();

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  StatsScreenVM vm = StatsScreenVM();

  List<String> sortFeatures = [
    "Newest",
    "Oldest",
    "High to Low",
    "Low to High"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm.fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return vm.expenseStore.expenses.isEmpty
              ? SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: noExpense(context))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pie Chart
                    Container(
                      alignment: Alignment.center,
                      height: 300,
                      child: PieChartWidget(
                        totalExpense:vm.expenseStore.totalExpense ,
                          expenses: vm.expenseStore.expenses,
                          categoryTotals: vm.expenseStore.categoryTotals,
                          categories: vm.expenseStore.categories),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSectionHeader('Expenses', 18),
                        Observer(builder: (context) {
                          return Container(
                            margin: EdgeInsets.only(right: 20),
                            child: DropdownButton<String>(
                              elevation: 10,
                              icon: const Icon(Icons.sort),
                              value: vm.selectedSortFeature,
                              // hint: const Text('Choose a category'),
                              // isExpanded: true,
                              items: sortFeatures.map((feature) {
                                return DropdownMenuItem<String>(
                                  value: feature,
                                  child: Text(feature), // Display enum name
                                );
                              }).toList(),
                              onChanged: (feature) {
                                vm.setSelectedSortFeature(feature!);
                                vm.sortExpense(feature);
                              },
                            ),
                          );
                        }),
                      ],
                    ),

                    Observer(builder: (context) {
                      return buildExpensesList(vm.sortedExpenses, vm);
                    }),
                  ],
                );
        }),
      ),
    );
  }
}
