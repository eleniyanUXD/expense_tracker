import 'package:flutter/material.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import 'package:expense_tracker/navigation/models/navigation_items.dart';
import 'widgets/bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const Center(child: Text('Transactions')),
    const Center(child: Text('Wallets')),
    const Center(child: Text('Budgets')),
    const Center(child: Text('Profile')),
  ];

  final List<NavigationItem> _navigationItems = const [
    NavigationItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    NavigationItem(
      label: 'Transaction',
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long,
    ),
    NavigationItem(
      label: 'Wallet',
      icon: Icons.account_balance_wallet_outlined,
      selectedIcon: Icons.account_balance_wallet,
    ),
    NavigationItem(
      label: 'Budget',
      icon: Icons.pie_chart_outline,
      selectedIcon: Icons.pie_chart,
    ),
    NavigationItem(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        items: _navigationItems,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
