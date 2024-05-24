  import 'package:flutter/material.dart';

Widget buildSectionHeader(String title,double fontSize) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style:  TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }