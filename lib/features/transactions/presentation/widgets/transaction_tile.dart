import 'package:flutter/material.dart';
import 'package:expense_tracker/features/transactions/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type.toLowerCase() == 'income';

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: CircleAvatar(
          backgroundColor: isIncome
              ? Colors.green.withValues(alpha: 0.12)
              : Colors.red.withValues(alpha: 0.12),
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${transaction.category} • ${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
        ),
        trailing: Text(
          '${isIncome ? '+' : '-'}₦${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
