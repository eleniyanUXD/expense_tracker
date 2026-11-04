import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/features/transactions/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/presentation/transaction_provider.dart';
import 'widgets/transaction_tile.dart';
import 'widgets/transaction_filter.dart';
import 'widgets/empty_transactions.dart';

class TransactionListsScreen extends StatefulWidget {
  const TransactionListsScreen({super.key});

  @override
  State<TransactionListsScreen> createState() => _TransactionListsScreenState();
}

class _TransactionListsScreenState extends State<TransactionListsScreen> {
  String _selectedFilter = 'All';

  // Filter transactions
  List<TransactionModel> _filterTransactions(
    List<TransactionModel> transactions,
  ) {
    if (_selectedFilter == 'Income') {
      return transactions
          .where((transaction) => transaction.type.toLowerCase() == 'income')
          .toList();
    }

    if (_selectedFilter == 'Expenses') {
      return transactions
          .where((transaction) => transaction.type.toLowerCase() == 'expense')
          .toList();
    }

    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Transaction List',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          final transactions = _filterTransactions(provider.transactions);

          return Column(
            children: [
              // Filter section
              Padding(
                padding: const EdgeInsets.all(16),
                child: TransactionFilter(
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),
              ),

              // Transaction list
              Expanded(
                child: transactions.isEmpty
                    ? const EmptyTransactions()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: transactions.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return TransactionTile(
                            transaction: transactions[index],
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
