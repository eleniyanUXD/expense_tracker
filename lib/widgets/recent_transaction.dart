import 'package:flutter/material.dart';

Widget _buildRecentTransactiions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Recent Transactions',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),

      _transactionTile('Food', '-N10, 000', Icons.fastfood, Colors.red),
      _transactionTile(
        'Transport',
        '-N10, 000',
        Icons.directions_bus,
        Colors.red,
      ),
      _transactionTile('Salary', '+N10, 000', Icons.work, Colors.green),
    ],
  );
}

Widget _transactionTile(
  String title,
  String amount,
  IconData icon,
  Color color,
) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color),
    ),
    title: Text(title),
    trailing: Text(
      amount,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    ),
  );
}
