import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msa_assessment/presentation/expense_list_screen/expense_list_screen_vm.dart';

import '../../model/transaction_model.dart';
import '../widgets/expense_list/expense_list.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({Key? key}) : super(key: key);

  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  ExpenseListScreenVM vm = ExpenseListScreenVM();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final args = ModalRoute.of(context)!.settings.arguments as List;
      vm.expenses = args[0] as List<Expense>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, vm.expenses);
          },
        ),
        automaticallyImplyLeading: false,
        title: const Text('All Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('This Week'),
            Observer(builder: (context) {
              return buildExpensesList(
                  vm.expenses.getTransactionsForCurrentWeek(), vm);
            }),
            buildSectionHeader('Past Expenses'),
            Observer(builder: (context) {
              return buildExpensesList(
                  vm.expenses.getTransactionsForPastWeeks(), vm);
            }),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


}
