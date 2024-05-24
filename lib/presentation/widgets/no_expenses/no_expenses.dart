import 'package:flutter/material.dart';
import 'package:msa_assessment/presentation/widgets/section_header/section_header.dart';


Widget noExpense(BuildContext context){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Image.asset('lib/helpers/resources/images/no_expenses.png')),
        buildSectionHeader('No Expenses', 15),
      ],
    ),
  );
}