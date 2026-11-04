import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import 'widgets/transaction_form_field.dart';
import 'widgets/transaction_type_selector.dart';
import 'widgets/transaction_category_selector.dart';
import 'widgets/transaction_date_picker.dart';
import 'transaction_provider.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen({super.key, required this.transaction});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _amountController;

  late String _selectedType;
  late String _selectedCategory;
  late DateTime _selectedDate;

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
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.transaction.title);

    _amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );

    _selectedType = widget.transaction.type;
    _selectedCategory = widget.transaction.category;
    _selectedDate = widget.transaction.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _updateTransaction() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedTransaction = TransactionModel(
        id: widget.transaction.id,
        title: _titleController.text.trim(),
        amount: double.parse(_amountController.text.trim()),
        category: _selectedCategory,
        type: _selectedType,
        date: _selectedDate,
      );

      await context.read<TransactionProvider>().updateTransaction(
        updatedTransaction,
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update transaction. Please try again.'),
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
          'Edit Transaction',
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
                hintText: 'Enter transaction title',
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
                categories: _categories,
                selectedCategory: _selectedCategory,
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
                  onPressed: _isLoading ? null : _updateTransaction,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                          'Save Changes',
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
