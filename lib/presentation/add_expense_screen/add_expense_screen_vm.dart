import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:mobx/mobx.dart';
import 'package:msa_assessment/helpers/service_result.dart';
import 'package:msa_assessment/model/transaction_model.dart';
import 'package:msa_assessment/presentation/add_expense_screen/add_expense_screen_model.dart';
import 'package:msa_assessment/utils/utlils.dart';

class AddExpenseScreenVM extends AddExpenseScreenModel {

void onPressed(String buttonText) {
  // Helper function to check if the calculatedAmount contains a decimal
  String doesContainDecimal(dynamic calculatedAmount) {
    if (calculatedAmount.toString().contains('.')) {
      List<String> splitDecimal = calculatedAmount.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return calculatedAmount = splitDecimal[0].toString();
      }
    }
    return calculatedAmount;
  }

  if (buttonText == "C") {
    // Clear the last character or reset the equation
    if (equation.isNotEmpty) {
      equation = equation.substring(0, equation.length - 1);
    }
    if (equation.isEmpty) {
      equation = "0";
    }
    setCalculatedAmount(equation);
  } else if (buttonText == "+/-") {
    // Toggle the sign of the equation
    if (equation[0] != '-') {
      equation = '-$equation';
    } else {
      equation = equation.substring(1);
    }
    setCalculatedAmount(equation);
  } else if (buttonText == "=") {
    // Ensure the equation is valid before evaluating
    if (equation.isNotEmpty && !isOperator(equation[equation.length - 1])) {
      expression = equation;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      expression = expression.replaceAll('%', '/100');

      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        setCalculatedAmount(eval.toString());
        if (expression.contains('%')) {
          setCalculatedAmount(doesContainDecimal(eval));
        }
      } catch (e) {
        setCalculatedAmount("Error");
      }
    } else {
      setCalculatedAmount("Error");
    }
  } else {
    // Append the button text to the equation
    if (equation == "0" && buttonText != ".") {
      equation = buttonText;
    } else {
      equation += buttonText;
    }
    print(equation);
    setCalculatedAmount(equation);
  }
}

// Helper function to check if a character is an operator
bool isOperator(String character) {
  return character == '+' || character == '-' || character == '×' || character == '÷' || character == '%';
}



  // onPressed(String buttonText) {
  //   // used to check if the calculatedAmount contains a decimal
  //   String doesContainDecimal(dynamic calculatedAmount) {
  //     if (calculatedAmount.toString().contains('.')) {
  //       List<String> splitDecimal = calculatedAmount.toString().split('.');
  //       if (!(int.parse(splitDecimal[1]) > 0)) {
  //         return calculatedAmount = splitDecimal[0].toString();
  //       }
  //     }
  //     return calculatedAmount;
  //   }

  //   if (buttonText == "C") {
  //     equation = equation.substring(0, equation.length - 1);
  //     if (equation == "") {
  //       equation = "0";
  //     }
  //   } else if (buttonText == "+/-") {
  //     if (equation[0] != '-') {
  //       equation = '-$equation';
  //     } else {
  //       equation = equation.substring(1);
  //     }
  //   } else if (buttonText == "=") {
  //     expression = equation;
  //     expression = expression.replaceAll('×', '*');
  //     expression = expression.replaceAll('÷', '/');
  //     expression = expression.replaceAll('%', '%');

  //     try {
  //       Parser p = Parser();
  //       Expression exp = p.parse(expression);

  //       ContextModel cm = ContextModel();
  //       setCalculatedAmount('${exp.evaluate(EvaluationType.REAL, cm)}');
  //       if (expression.contains('%')) {
  //         setCalculatedAmount(doesContainDecimal(calculatedAmount));
  //       }
  //     } catch (e) {
  //       setCalculatedAmount("Error");
  //     }
  //   } else {
  //     if (equation == "0") {
  //       equation = buttonText;
  //       setCalculatedAmount(equation);
  //     } else {
  //       equation = equation + buttonText;
  //       setCalculatedAmount(equation);
  //     }
  //   }
  // }

  setExpenseData() {
    try {
      if (expense != null) {
        setCalculatedAmount(expense!.amount.toString());
        equation = expense!.amount.toString();
        setExpenseCategory(expense!.category);
        selectedDate = expense!.createdAt;
        setFormattedDate(DateFormat('dd-MM-yyyy').format(expense!.createdAt));
        setNotes(expense!.description!);
      }
    } catch (e) {
      print(e.toString());
    }
  }


  Future<void> performCrud() async{
    try {
      operation == "Add" ? await addExpense() : await updateExpense();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addExpense() async {
    try {
      var expenseData = Expense(
          id: generateUuid(code: 'expense'),
          category: selectedCategory,
          userID: "user-12",
          description: notes,
          amount: double.parse(calculatedAmount),
          createdAt: DateFormat('dd-MM-yyyy').parse(formattedDate));
      var res = await localStorageService.createExpense(expenseData);
      print(res.statusCode);
      if (res.statusCode == StatusCode.success) {
        await displayExpenses();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> displayExpenses() async {
    try {
      var res = await localStorageService.getExpenses();
      expenseStore.setExpenses(ObservableList.of(res.data!));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateExpense() async {
    try {
      var expenseData = Expense(
          id: expense!.id,
          category: selectedCategory,
          userID: expense!.userID,
          description: notes,
          isDeleted: expense!.isDeleted,
          amount: double.parse(calculatedAmount),
          createdAt: DateFormat('dd-MM-yyyy').parse(formattedDate));
      var res = await localStorageService.updateExpense(expenseData);
      if (res.statusCode == StatusCode.success) {
        await displayExpenses();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
