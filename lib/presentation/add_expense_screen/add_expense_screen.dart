import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:msa_assessment/presentation/add_expense_screen/add_expense_screen_vm.dart';

import '../../model/transaction_model.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return Column(
            children: [
              vm.operation == "Add"
                  ? const Text('Add Expense')
                  : const Text('Update Expense'),
              TextFormField(
                controller:
                    dateController, //editing controller of this TextField
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true, // when true user cannot edit text

                onTap: () async {
                  selectDate(context);
                },
              ),
              DropdownButton<ExpenseCategory>(
                value: vm.selectedCategory,
                hint: const Text('Choose a category'),
                isExpanded: true,
                items: ExpenseCategory.values.map((ExpenseCategory category) {
                  return DropdownMenuItem<ExpenseCategory>(
                    value: category,
                    child:
                        Text(category.name.toUpperCase()), // Display enum name
                  );
                }).toList(),
                onChanged: (ExpenseCategory? category) {
                  vm.setExpenseCategory(category!);
                },
              ),
              TextField(
                controller: notesController,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  // labelText: 'Enter expression',

                  border: OutlineInputBorder(),
                ),
                onChanged: vm.setNotes,
                keyboardType: TextInputType.text,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        vm.calculatedAmount,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        vm.setCalculatedAmount('');
                        vm.equation = "";
                      },
                      icon: const Icon(
                        Icons.backspace,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
      
              CalculatorGrid(onPressed: vm.onPressed),
              Observer(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      print(!(RegExp(r'[+\-*/]').hasMatch(vm.calculatedAmount.trim())));
                      if (!(RegExp(r'[+\-*/]').hasMatch(vm.calculatedAmount.trim())) == true) {
                        await vm.performCrud();
                        Navigator.pop(context, vm.expenseStore.expenses);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Complete the calculation!')));
                      }
                    },
                    child: const Text('Done'),
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
