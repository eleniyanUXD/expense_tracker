import 'package:hive/hive.dart';

class StorageService {
  static final Box box = Hive.box('transactions');

  // Add transaction
  static Future<void> saveTransaction(Map tx) async {
    await box.add(tx);
  }

  // Get all transactions
  static List<Map<String, dynamic>> getTransactions() {
    return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Delete by index
  static Future<void> deleteTransaction(int index) async {
    await box.deleteAt(index);
  }

  // Clear all (optional)
  static Future<void> clearAll() async {
    await box.clear();
  }
}
