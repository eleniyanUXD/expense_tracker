import 'package:flutter/material.dart';
import 'widgets/transaction_form_field.dart';
import 'widgets/transaction_type_selector.dart';
import 'widgets/transaction_category_selector.dart';
import 'widgets/transaction_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/features/transactions/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/presentation/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedType = 'expense';
  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Salary',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _saveTransaction() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final transaction = TransactionModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        amount: double.parse(_amountController.text.trim()),
        category: _selectedCategory,
        type: _selectedType,
        date: _selectedDate,
      );

      await context.read<TransactionProvider>().addTransaction(transaction);

      if (!mounted) return;

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save transaction. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
          'Add Transaction',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransactionFormField(
                label: 'Transaction Title',
                hintText: 'e.g. Grocery shopping',
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a transaction title';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TransactionFormField(
                label: 'Amount',
                hintText: 'Enter amount',
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an amount';
                  }

                  final amount = double.tryParse(value);

                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              TransactionTypeSelector(
                selectedType: _selectedType,
                onTypeChanged: (type) {
                  setState(() {
                    _selectedType = type;
                  });
                },
              ),

              const SizedBox(height: 24),

              TransactionCategorySelector(
                selectedCategory: _selectedCategory,
                categories: _categories,
                onCategoryChanged: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),

              const SizedBox(height: 24),

              TransactionDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveTransaction,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save Transaction',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
