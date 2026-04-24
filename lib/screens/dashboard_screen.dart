import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> transactions = [];

  void processRecurring() {
    final now = DateTime.now();

    for (var t in transactions) {
      if (t['isRecurring'] == true && t['createdAt'] != null) {
        final created = DateTime.parse(t['createdAt']);
        final freq = t['frequency'];

        bool shouldAdd = false;

        if (freq == 'daily' && now.difference(created).inDays >= 1) {
          shouldAdd = true;
        }

        if (freq == 'weekly' && now.difference(created).inDays >= 7) {
          shouldAdd = true;
        }

        if (freq == 'monthly' && now.difference(created).inDays >= 30) {
          shouldAdd = true;
        }

        if (shouldAdd) {
          StorageService.saveTransaction({
            ...t,
            'createdAt': now.toIso8601String(),
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadTransactions();
    processRecurring(); 
  }

  double getIncome() {
    double total = 0;
    for (var t in transactions) {
      if (t['type'] == "income") {
        total += (t['amount'] as num).toDouble();
      }
    }
    return total;
  }

  double getExpense() {
    double total = 0;
    for (var t in transactions) {
      if (t['type'] == "expense") {
        total += (t['amount'] as num).toDouble();
      }
    }
    return total;
  }

  double getBalance() {
    return getIncome() - getExpense();
  }

  void loadTransactions() {
    final data = StorageService.getTransactions();

    setState(() {
      transactions = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),

            _buildBalanceCard(),
            const SizedBox(height: 20),

            _buildIncomeExpenseRow(),
            const SizedBox(height: 20),

            _buildRecentTransactions(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );

          if (result != null) {
            await StorageService.saveTransaction(result);

            loadTransactions();
          }
        },
        backgroundColor: const Color.fromARGB(255, 3, 6, 167),
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text('Fuad', style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 3, 6, 167),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            "₦${getBalance().toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '+5.2% from last month',
            style: TextStyle(color: Colors.greenAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMiniCard(
          'Income',
          "₦${getIncome().toStringAsFixed(0)}",
          Colors.green,
        ),
        _buildMiniCard(
          'Expense',
          "₦${getExpense().toStringAsFixed(0)}",
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildMiniCard(String title, String amount, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            "No transactions yet",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(transactions.length, (index) {
        final reversedIndex = transactions.length - 1 - index;
        final t = transactions[reversedIndex];

        return ListTile(
          leading: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: t['type'] == 'income' ? Colors.green : Colors.red,
            ),
          ),

          title: Text(t['title']),

          subtitle: Text("${t['category']} • ${t['type']}"),

          trailing: Text(
            "₦${(t['amount'] as num).toStringAsFixed(0)}",
            style: TextStyle(
              color: t['type'] == 'income' ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),

          onLongPress: () async {
            await StorageService.deleteTransaction(reversedIndex);
            loadTransactions();
          },
        );
      }),
    );
  }
}
