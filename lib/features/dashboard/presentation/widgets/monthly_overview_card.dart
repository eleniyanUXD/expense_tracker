import 'package:flutter/material.dart';

class MonthlyOverviewCard extends StatelessWidget {
  final double monthlyIncome;
  final double monthlyExpenses;
  final double monthlyBalance;

  const MonthlyOverviewCard({
    super.key,
    required this.monthlyIncome,
    required this.monthlyExpenses,
    required this.monthlyBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildOverviewRow('Income', monthlyIncome, Colors.green),
            const SizedBox(height: 16),

            _buildOverviewRow('Expenses', monthlyExpenses, Colors.red),
            const SizedBox(height: 16),

            _buildOverviewRow('Balance', monthlyBalance, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewRow(String title, double amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        Text(
          '₦${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
