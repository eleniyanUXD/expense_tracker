import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_tracker/database/tables.dart';

class AppDatabase {
  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox<Map>(AppTables.transactions);
    await Hive.openBox<Map>(AppTables.categories);
    await Hive.openBox<Map>(AppTables.wallets);
  }

  static Box<Map> get transactions =>
      Hive.box<Map>(AppTables.transactions);

  static Box<Map> get categories =>
      Hive.box<Map>(AppTables.categories);

  static Box<Map> get wallets =>
      Hive.box<Map>(AppTables.wallets);
}