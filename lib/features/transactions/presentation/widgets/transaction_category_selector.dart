import 'package:flutter/material.dart';

class TransactionCategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const TransactionCategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = selectedCategory == category;

            return ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) => onCategoryChanged(category),
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              selectedColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
