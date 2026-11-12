import 'package:flutter/material.dart';

class DashboardFilter extends StatefulWidget {
  final Function(String) onFilterChanged;

  const DashboardFilter({super.key, required this.onFilterChanged});

  @override
  State<DashboardFilter> createState() => _DashboardFilterState();
}

class _DashboardFilterState extends State<DashboardFilter> {
  String selectedFilter = 'This Month';
  Color checkmarkColor = Colors.white;

  final List<String> filters = ['This Week', 'This Month', 'This Year'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter;

        return ChoiceChip(
          label: Text(
            filter,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          selected: isSelected,
          selectedColor: Colors.blue,
          backgroundColor: Colors.grey.shade200,
          showCheckmark: true,
          checkmarkColor: checkmarkColor,
          onSelected: (selected) {
            if (!selected) return;

            setState(() {
              selectedFilter = filter;
            });

            widget.onFilterChanged(filter);
          },
        );
      }).toList(),
    );
  }
}
