import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/features/wallet/models/wallet_model.dart';

class WalletDao {
  final Box<Map> _box = AppDatabase.wallets;

  Future<void> addWallet(WalletModel wallet) async {
    await _box.put(wallet.id, {
      'id': wallet.id,
      'name': wallet.name,
      'balance': wallet.balance,
      'currency': wallet.currency,
      'createdAt': wallet.createdAt.toIso8601String(),
    });
  }

  List<WalletModel> getWallets() {
    return _box.values.map((data) {
      return WalletModel(
        id: data['id'] as String,
        name: data['name'] as String,
        balance: (data['balance'] as num).toDouble(),
        currency: data['currency'] as String,
        createdAt: DateTime.parse(data['createdAt'] as String),
      );
    }).toList();
  }

  Future<void> updateWallet(WalletModel wallet) async {
    await addWallet(wallet);
  }

  Future<void> deleteWallet(String id) async {
    await _box.delete(id);
  }
}
