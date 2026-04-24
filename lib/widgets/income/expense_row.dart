import 'package:flutter/material.dart';

Widget _buildIncomeExpenseRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildMiniCard('Income', 'N240, 000',  Colors.green),
      _buildMiniCard('Expense', 'N100, 000', Colors.red),
    ],
  );
}

Widget _buildMiniCard(String title, String amount, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(),),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
