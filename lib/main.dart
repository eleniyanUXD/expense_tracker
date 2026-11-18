import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/database/daos/transaction_dao.dart';
import 'package:expense_tracker/database/daos/wallet_dao.dart';
import 'package:expense_tracker/features/transactions/data/transaction_repository.dart';
import 'package:expense_tracker/features/transactions/presentation/transaction_provider.dart';
import 'package:expense_tracker/features/wallet/data/wallet_repository.dart';
import 'package:expense_tracker/features/wallet/presentation/wallet_provider.dart';
import 'package:expense_tracker/navigation/main_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive database.
  await AppDatabase.init();

  // Transaction database layers.
  final transactionDao = TransactionDao();
  final transactionRepository = TransactionRepository(transactionDao);

  // Wallet database layers.
  final walletDao = WalletDao();
  final walletRepository = WalletRepository(walletDao);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              TransactionProvider(transactionRepository)..loadTransactions(),
        ),

        ChangeNotifierProxyProvider<TransactionProvider, WalletProvider>(
          create: (_) => WalletProvider(walletRepository)..loadWallets(),
          update: (_, transactionProvider, walletProvider) {
            return walletProvider!
              ..updateTransactions(transactionProvider.transactions);
          },
        ),
      ],
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
      home: const MainNavigation(),
    );
  }
}
