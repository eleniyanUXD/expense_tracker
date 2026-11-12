import 'package:flutter/material.dart';

class CategoryLegend extends StatelessWidget {
  final Map<String, double> expenseByCategory;
  final List<Color> chartColors;

  const CategoryLegend({
    super.key,
    required this.expenseByCategory,
    required this.chartColors,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: expenseByCategory.keys.toList().asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        final color = chartColors[index % chartColors.length];

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(category),
          ],
        );
      }).toList(),
    );
  }
}
