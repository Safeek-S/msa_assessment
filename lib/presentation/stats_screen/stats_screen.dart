import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msa_assessment/presentation/stats_screen/stats_screen_vm.dart';

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pie Chart
              Container(
                alignment: Alignment.center,
                height: 300,
                child: PieChartWidget(
                    expenses: vm.expenseStore.expenses,
                    categoryTotals: vm.expenseStore.categoryTotals,
                    categories: vm.expenseStore.categories),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expenses'),
                  Expanded(
                    child: Observer(builder: (context) {
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButton<String>(
                          icon: Icon(Icons.sort),
                          value: vm.selectedSortFeature,
                          // hint: const Text('Choose a category'),
                          isExpanded: true,
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
                  ),
                ],
              ),

        
                 Observer(
                   builder: (context) {
                     return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: vm.sortedExpenses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(vm.sortedExpenses[index].category.name),
                          subtitle: Text(
                              'Amount: ${vm.sortedExpenses[index].amount}, Date: ${vm.sortedExpenses[index].createdAt}'),
                        );
                      },
                                     );
                   }
                 ),
             
            ],
          );
        }),
      ),
    );
  }
}
