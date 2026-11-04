import 'package:flutter/material.dart';

class TransactionFilter extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const TransactionFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  static const List<String> filters = ['All', 'Income', 'Expenses'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) => onFilterChanged(filter),
              showCheckmark: false,
              selectedColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
