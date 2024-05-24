import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msa_assessment/presentation/widgets/pie_chart/pie_chart_model.dart';

import '../../../model/expense_model.dart';
import '../../../utils/utlils.dart';
import 'indicator.dart';

class PieChartWidget extends StatefulWidget {
  final List<Expense> expenses;
  final List<String> categories;
  final double totalExpense;
  final Map<String, double> categoryTotals;
  const PieChartWidget(
      {super.key,
      required this.expenses,
      required this.categoryTotals,
      required this.categories, required this.totalExpense,});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  PieChartModel model = PieChartModel();
  
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
            flex: 2,
            child: Observer(
              builder: (context) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              model.setTouchIndex(-1);
                              return;
                            }
                            model.setTouchIndex(pieTouchResponse
                                .touchedSection!.touchedSectionIndex);
                         
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections:
                          calculateSections(widget.expenses, widget.categoryTotals,widget.totalExpense),
                    ),
                  ),
                );
              }
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(children: [
                  Indicator(
                    color: getColorForCategory(index),
                    text: widget.categories[index],
                    isSquare: true,
                  ),
                  const SizedBox(
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

 

  List<PieChartSectionData> calculateSections(
      List<Expense> expenses, Map<String, double> categoryTotals,double totalExpense) {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    List<PieChartSectionData> sections = [];
    categoryTotals.keys.toList().asMap().forEach((index, category) {
      final isTouched = index == model.touchIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 70.0 : 50.0;
      sections.add(
        PieChartSectionData(
          color: getColorForCategory(index),
          value: categoryTotals[category]!,
          title:
              '${(categoryTotals[category]! / totalExpense * 100).toStringAsFixed(2)}%',
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
