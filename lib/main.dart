import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/main_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('transactions');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',

      initialRoute: '/auth',

      routes: {
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const MainNavigation(),
      },
    );
  }
}
