import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/features/transactions/presentation/transaction_provider.dart';
import 'package:expense_tracker/features/transactions/presentation/widgets/transaction_tile.dart';
import 'package:expense_tracker/features/dashboard/presentation/widgets/category_spending_row.dart';
import 'package:expense_tracker/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:expense_tracker/features/dashboard/presentation/widgets/monthly_overview_card.dart';
import 'package:expense_tracker/features/dashboard/presentation/widgets/spending_chart.dart';
import 'package:expense_tracker/features/dashboard/presentation/widgets/dashboard_filter.dart';
import 'package:expense_tracker/features/transactions/models/transaction_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedFilter = 'This Month';

  List<TransactionModel> _filterTransactions(
    List<TransactionModel> transactions,
  ) {
    final now = DateTime.now();

    return transactions.where((transaction) {
      switch (selectedFilter) {
        case 'This Week':
          final startOfWeek = DateTime(
            now.year,
            now.month,
            now.day - (now.weekday - 1),
          );

          return !transaction.date.isBefore(startOfWeek) &&
              transaction.date.isBefore(
                startOfWeek.add(const Duration(days: 7)),
              );

        case 'This Month':
          return transaction.date.month == now.month &&
              transaction.date.year == now.year;

        case 'This Year':
          return transaction.date.year == now.year;

        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allTransactions = context.watch<TransactionProvider>().transactions;

    final transactions = _filterTransactions(allTransactions);

    final totalIncome = transactions
        .where((transaction) => transaction.type.toLowerCase() == 'income')
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);

    final totalExpenses = transactions
        .where((transaction) => transaction.type.toLowerCase() == 'expense')
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);

    final totalBalance = totalIncome - totalExpenses;

    final recentTransactions = [...transactions]
      ..sort((a, b) => b.date.compareTo(a.date));

    final latestTransactions = recentTransactions.take(5).toList();

    final expenseByCategory = <String, double>{};

    for (final transaction in transactions) {
      if (transaction.type.toLowerCase() == 'expense') {
        expenseByCategory.update(
          transaction.category,
          (amount) => amount + transaction.amount,
          ifAbsent: () => transaction.amount,
        );
      }
    }

    final categorySpending = expenseByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final highestCategoryAmount = categorySpending.isEmpty
        ? 0.0
        : categorySpending.first.value;

    final now = DateTime.now();

    final monthlyTransactions = transactions.where((transaction) {
      return transaction.date.month == now.month &&
          transaction.date.year == now.year;
    }).toList();

    final monthlyIncome = monthlyTransactions
        .where((transaction) => transaction.type.toLowerCase() == 'income')
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);

    final monthlyExpenses = monthlyTransactions
        .where((transaction) => transaction.type.toLowerCase() == 'expense')
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);

    final monthlyBalance = monthlyIncome - monthlyExpenses;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Balance', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                '₦ ${totalBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Income',
                      amount: totalIncome,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      title: 'Expenses',
                      amount: totalExpenses,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 12),

              if (latestTransactions.isEmpty)
                const Center(
                  child: Text(
                    'No transactions available.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              else
                ...latestTransactions.map((transaction) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TransactionTile(transaction: transaction),
                  );
                }),

              const SizedBox(height: 24),

              const Text(
                'Spending by Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              if (categorySpending.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('No expense data available'),
                  ),
                )
              else
                ...categorySpending.map(
                  (entry) => CategorySpendingRow(
                    category: entry.key,
                    amount: entry.value,
                    maxAmount: highestCategoryAmount,
                  ),
                ),

              const SizedBox(height: 20),

              MonthlyOverviewCard(
                monthlyIncome: monthlyIncome,
                monthlyExpenses: monthlyExpenses,
                monthlyBalance: monthlyBalance,
              ),

              const SizedBox(height: 20),

              const Text(
                'Spending Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              SpendingChart(expenseByCategory: expenseByCategory),

              const SizedBox(height: 20),

              DashboardFilter(
                onFilterChanged: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
