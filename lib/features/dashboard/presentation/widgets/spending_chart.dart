import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'category_legend.dart';

class SpendingChart extends StatelessWidget {
  final Map<String, double> expenseByCategory;

  static const List<Color> chartColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.pink,
  ];

  const SpendingChart({super.key, required this.expenseByCategory});

  @override
  Widget build(BuildContext context) {
    final totalExpenses = expenseByCategory.values.fold<double>(
      0,
      (sum, amount) => sum + amount,
    );

    if (totalExpenses == 0) {
      return const Center(child: Text('No expenses recorded yet.'));
    }

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 45,
              sections: expenseByCategory.entries.toList().asMap().entries.map((
                entry,
              ) {
                final index = entry.key;
                final categoryEntry = entry.value;

                final percentage = (categoryEntry.value / totalExpenses) * 100;

                return PieChartSectionData(
                  value: categoryEntry.value,
                  color: chartColors[index % chartColors.length],
                  title: '${percentage.toStringAsFixed(1)}%',
                  radius: 65,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: 20),

        CategoryLegend(
          expenseByCategory: expenseByCategory,
          chartColors: chartColors,
        ),
      ],
    );
  }
}
