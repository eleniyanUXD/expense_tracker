import 'package:expense_tracker/features/dashboard/presentation/dashboard_screen.dart';
import 'package:expense_tracker/features/transactions/presentation/add_transaction_screen.dart';
import 'package:expense_tracker/features/transactions/presentation/edit_transaction_screen.dart';
import 'package:expense_tracker/features/transactions/presentation/transaction_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/database/daos/transaction_dao.dart';
import 'package:expense_tracker/features/transactions/data/transaction_repository.dart';
import 'package:expense_tracker/features/transactions/presentation/transaction_provider.dart';
import 'package:expense_tracker/features/transactions/models/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive database first
  await AppDatabase.init();

  // Create the database layers
  final transactionDao = TransactionDao();
  final transactionRepository = TransactionRepository(transactionDao);

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          TransactionProvider(transactionRepository)..loadTransactions(),
      child: const ExpenseTrackerApp(),
    ),
  );
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: DashboardScreen(),
    );
  }
}
