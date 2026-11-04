import 'package:flutter/material.dart';

class TransactionTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  const TransactionTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaction Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTypeButton(
                label: 'Income',
                icon: Icons.trending_up,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTypeButton(
                label: 'Expense',
                icon: Icons.trending_down,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeButton({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = selectedType == label.toLowerCase();

    return InkWell(
      onTap: () => onTypeChanged(label.toLowerCase()),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
