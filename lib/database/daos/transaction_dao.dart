import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/database/tables.dart';
import 'package:expense_tracker/features/transactions/models/transaction_model.dart';

class TransactionDao {
  final Box<Map> _box = AppDatabase.transactions;

  // Add a transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await _box.put(transaction.id, {
      TransactionFields.id: transaction.id,
      TransactionFields.title: transaction.title,
      TransactionFields.amount: transaction.amount,
      TransactionFields.category: transaction.category,
      TransactionFields.type: transaction.type,
      TransactionFields.date: transaction.date.toIso8601String(),
    });
  }

  // Get all transactions
  List<TransactionModel> getTransactions() {
    return _box.values.map((data) {
      return TransactionModel(
        id: data[TransactionFields.id] as String,
        title: data[TransactionFields.title] as String,
        amount: (data[TransactionFields.amount] as num).toDouble(),
        category: data[TransactionFields.category] as String,
        type: data[TransactionFields.type] as String,
        date: DateTime.parse(data[TransactionFields.date] as String),
      );
    }).toList();
  }

  // Update a transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    await addTransaction(transaction);
  }

  // Delete a transaction
  Future<void> deleteTransaction(String id) async {
    await _box.delete(id);
  }
}
