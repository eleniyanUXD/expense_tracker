import 'package:flutter/material.dart';
import '../data/transaction_repository.dart';
import '../models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _repository;

  TransactionProvider(this._repository);

  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  // Load transactions
  void loadTransactions() {
    _transactions = _repository.getTransactions();
    notifyListeners();
  }

  // Add transaction
  Future<void> addTransaction(TransactionModel transaction) async {
  await _repository.addTransaction(transaction);
  loadTransactions();
}


  // Update transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    await _repository.updateTransaction(transaction);
    loadTransactions();
  }

  // Delete transaction
  Future<void> deleteTransaction(String id) async {
    await _repository.deleteTransaction(id);
    loadTransactions();
  }
}