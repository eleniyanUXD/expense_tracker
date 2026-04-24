import 'package:flutter/material.dart';

Widget _buildBalanceCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 3, 6, 167),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Balance',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'N500,000',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '+5.2% from last month',
          style: TextStyle(color: Colors.greenAccent),
        ),
      ],
    ),
  );
}
