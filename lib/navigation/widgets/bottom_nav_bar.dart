import 'package:flutter/material.dart';
import 'package:expense_tracker/navigation/models/navigation_items.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<NavigationItem> items;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            );
          }
          return const TextStyle(color: Colors.grey);
        }),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemSelected,
        indicatorColor: Theme.of(context).primaryColor.withOpacity(0.1),

        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,

        destinations: items.map((item) {
          return NavigationDestination(
            icon: Icon(item.icon, color: Colors.grey),
            selectedIcon: Icon(
              item.selectedIcon,
              color: Theme.of(context).primaryColor,
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}
