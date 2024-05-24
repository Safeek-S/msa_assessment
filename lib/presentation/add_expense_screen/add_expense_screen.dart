import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:msa_assessment/presentation/add_expense_screen/add_expense_screen_vm.dart';

import '../../model/expense_model.dart';
import '../../utils/utlils.dart';
import '../widgets/calculator_widget/calculator_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen();

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final AddExpenseScreenVM vm = AddExpenseScreenVM();
  List<ReactionDisposer>? disposers;
  TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final args = ModalRoute.of(context)!.settings.arguments as List;
      vm.operation = args[0] as String;
      vm.expense = args[1] as Expense?;

      vm.setExpenseData();
    });

    dateController.text = vm.formattedDate;
    disposers = [
      reaction<String>((_) => vm.calculatedAmount, (amount) {
        amountController.text = amount;
      }),
      reaction<String>((_) => vm.formattedDate, (date) {
        dateController.text = date;
      }),
      reaction<String>((_) => vm.notes, (notes) {
        notesController.text = notes;
      })
    ];
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    dateController.dispose();
    notesController.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: vm.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (selectedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(
          selectedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      vm.setFormattedDate(formattedDate);
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await vm.fetchExpenses();
            Navigator.pop(context, vm.expenseStore.expenses);
          },
        ),
        automaticallyImplyLeading: false,
        title: vm.operation == "Add"
            ? const Text('Add Expense')
            : const Text('Update Expense'),
      ),
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.date_range,
                      color: Color(0xff6200EE),
                      size: 25,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    selectDate(context);
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                DropdownButton<ExpenseCategory>(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                  value: vm.selectedCategory,
                  // hint: const Text('Choose a category'),
                  isExpanded: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  items: ExpenseCategory.values.map((ExpenseCategory category) {
                    return DropdownMenuItem<ExpenseCategory>(
                      value: category,
                      child: Text(
                          category.name.toUpperCase()), // Display enum name
                    );
                  }).toList(),
                  onChanged: (ExpenseCategory? category) {
                    vm.setExpenseCategory(category!);
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                TextField(
                  controller: notesController,
                  minLines: 4,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Add notes',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: vm.setNotes,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.01),
                        child: const Text(
                          '\u{20B9}',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            vm.calculatedAmount,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          vm.setCalculatedAmount('');
                          vm.equation = "";
                        },
                        icon: const Icon(
                          Icons.backspace_outlined,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                CalculatorGrid(onPressed: vm.onPressed),
                SizedBox(
                  height: height * 0.03,
                ),
                Observer(builder: (context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: const Color(0xff6200EE),
                        fixedSize: Size(width * 0.9, height * 0.05)),
                    onPressed: () async {
                     
                      if (!(RegExp(r'[+\-*/]')
                              .hasMatch(vm.calculatedAmount.trim())) ==
                          true) {
                        await vm.performCrud();
                        Navigator.pop(context, vm.expenseStore.expenses);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Complete the calculation!')));
                      }
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
