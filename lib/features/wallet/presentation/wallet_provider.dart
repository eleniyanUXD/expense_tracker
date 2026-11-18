import 'package:flutter/material.dart';
import 'package:expense_tracker/features/wallet/data/wallet_repository.dart';
import 'package:expense_tracker/features/wallet/models/wallet_model.dart';
import 'package:expense_tracker/features/transactions/models/transaction_model.dart';

class WalletProvider extends ChangeNotifier {
  final WalletRepository _repository;

  WalletProvider(this._repository);

  List<WalletModel> _wallets = [];
  List<TransactionModel> _transactions = [];

  List<WalletModel> get wallets => _wallets;

  // Receive updated transactions from TransactionProvider.
  void updateTransactions(List<TransactionModel> transactions) {
    _transactions = List<TransactionModel>.from(transactions);
  }

  // Calculate the current balance of an individual wallet.
  double getWalletBalance(String walletId) {
    final wallet = _wallets.firstWhere((wallet) => wallet.id == walletId);

    double balance = wallet.balance;

    for (final transaction in _transactions) {
      if (transaction.walletId != walletId) continue;

      if (transaction.type.toLowerCase() == 'income') {
        balance += transaction.amount;
      } else if (transaction.type.toLowerCase() == 'expense') {
        balance -= transaction.amount;
      }
    }

    debugPrint('Wallet ID: $walletId');

    for (final transaction in _transactions) {
      debugPrint(
        'Transaction: ${transaction.title}, '
        'Type: ${transaction.type}, '
        'Wallet ID: ${transaction.walletId}, '
        'Amount: ${transaction.amount}',
      );
    }

    debugPrint('Calculated wallet balance: $balance');

    return balance;
  }

  // Calculate balances separately for each currency.
  Map<String, double> get totalBalancesByCurrency {
    final balances = <String, double>{};

    for (final wallet in _wallets) {
      balances[wallet.currency] =
          (balances[wallet.currency] ?? 0) + getWalletBalance(wallet.id);
    }

    return balances;
  }

  void loadWallets() {
    _wallets = _repository.getWallets();
    notifyListeners();
  }

  Future<void> addWallet(WalletModel wallet) async {
    await _repository.addWallet(wallet);
    loadWallets();
  }

  Future<void> updateWallet(WalletModel wallet) async {
    await _repository.updateWallet(wallet);
    loadWallets();
  }

  Future<void> deleteWallet(String id) async {
    await _repository.deleteWallet(id);
    loadWallets();
  }
}
