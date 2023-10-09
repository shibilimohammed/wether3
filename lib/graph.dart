// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:wether/api.dart';
import 'package:wether/themechange.dart';

class SpendFrequencyChart extends StatelessWidget {
  const SpendFrequencyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedProvider = Provider.of<DarkThemePreference>(context);
    final proobj = Provider.of<SProvider>(context);
    final color2 = Color.fromARGB(255, 106, 150, 200);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      child: Column(children: [
        AspectRatio(
            aspectRatio: 3.9,
            child: LineChart(LineChartData(
              minX: 0,
              minY: 0,
              maxX: 11,
              maxY: 6,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(show: false),
              lineBarsData: [
                LineChartBarData(
                    spots: const [
                      FlSpot(0, 0),
                      FlSpot(2, 0.8),
                      FlSpot(2, 2),
                      FlSpot(2.8, 2.4),
                      FlSpot(4.4, 1.3),
                      FlSpot(5.6, 3.3),
                      FlSpot(7.2, 1.8),
                      FlSpot(8.2, 3.3),
                      FlSpot(9.4, 5.2),
                      FlSpot(11, 4)
                    ],
                    //        color: sharedProvider.light == true
                    // ? Color.fromARGB(255, 86, 154, 232)
                    // : Color.fromARGB(255, 34, 41, 46),
                    color: Colors.white,
                    barWidth: 1,
                    dotData: const FlDotData(show: false),
                    isCurved: true,
                    curveSmoothness: 0.4,
                    belowBarData: BarAreaData(
                        show: true,
                        color: sharedProvider.light != true
                            ? Color.fromARGB(255, 34, 41, 46)
                            : color2))
              ],
            ))),
      ]),
    );
  }
}
