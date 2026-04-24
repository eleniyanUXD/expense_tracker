import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String type = 'expense';
  String category = 'Food';

  bool isRecurring = false;
  String frequency = 'daily';

  final List<String> categories = [
    'Food',
    'Transport',
    'Shopping',
    'Salary',
    'Bills',
  ];

  void saveTransaction() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid data")));
      return;
    }

    final transaction = {
      'title': title,
      'amount': amount,
      'type': type,
      'category': category,
      'isRecurring': isRecurring,
      'frequency': frequency,
      'createdAt': DateTime.now().toIso8601String(),
    };

    Navigator.pop(context, transaction);
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Color.fromARGB(255, 3, 6, 167), width: 2),
      ),
    );
  }

  Widget gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: _inputStyle("Title"),
            ),

            gap(),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: _inputStyle("Amount"),
            ),

            gap(),

            DropdownButtonFormField<String>(
              value: type,
              items: const [
                DropdownMenuItem(value: 'income', child: Text('Income')),
                DropdownMenuItem(value: 'expense', child: Text('Expense')),
              ],
              onChanged: (value) => setState(() => type = value!),
              decoration: _inputStyle("Type"),
            ),

            gap(),

            DropdownButtonFormField<String>(
              value: category,
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => category = value!),
              decoration: _inputStyle("Category"),
            ),

            gap(),

            SwitchListTile(
              title: const Text("Recurring Transaction"),
              value: isRecurring,
              onChanged: (val) => setState(() => isRecurring = val),
            ),

            if (isRecurring)
              DropdownButtonFormField<String>(
                value: frequency,
                items: const [
                  DropdownMenuItem(value: 'daily', child: Text('Daily')),
                  DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                  DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                ],
                onChanged: (value) => setState(() => frequency = value!),
                decoration: _inputStyle("Frequency"),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveTransaction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  backgroundColor: const Color.fromARGB(255, 3, 6, 167),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
