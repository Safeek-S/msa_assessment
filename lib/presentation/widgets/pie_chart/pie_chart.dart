import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../model/transaction_model.dart';
import 'indicator.dart';

class PieChartWidget extends StatefulWidget {
  final List<Expense> expenses;
  final List<String> categories;
  final Map<String, double> categoryTotals;
  const PieChartWidget(
      {super.key,
      required this.expenses,
      required this.categoryTotals,
      required this.categories});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections:
                      calculateSections(widget.expenses, widget.categoryTotals),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(children: [
                  Indicator(
                    color: getColorForCategory(index),
                    text: widget.categories[index],
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ]);
              },
              itemCount: widget.categories.length,
            ),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  Color getColorForCategory(int index) {
    const List<Color> categoryColors = [
      Color(0xFF50E4FF), // Cyan
      Color(0xFFFFC300), // Yellow
      Color(0xFFFF683B), // Orange
      Color(0xFF3BFF49), // Green
      Color(0xFF6E1BFF), // Purple
    ];
    return categoryColors[index % categoryColors.length];
  }

  List<Color> _generateColors(int count) {
    final List<Color> colors = [];
    final Random random = Random();
    for (int i = 0; i < count; i++) {
      final color = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
      colors.add(color);
    }
    return colors;
  }

  List<PieChartSectionData> calculateSections(
      List<Expense> expenses, Map<String, double> categoryTotals) {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    List<PieChartSectionData> sections = [];
    categoryTotals.keys.toList().asMap().forEach((index, category) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      sections.add(
        PieChartSectionData(
          color: getColorForCategory(index),
          value: categoryTotals[category]!,
          title:
              '${(categoryTotals[category]! / expenses.length).toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows),
        ),
      );
    });

    return sections;
  }
}
