import 'package:flutter/material.dart';
import 'package:dream_flow/screens/financial/financial_screen.dart';
import 'package:dream_flow/screens/tasks/tasks_screen.dart';
import 'package:dream_flow/screens/lists/lists_screen.dart';
import 'package:dream_flow/theme/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FinancialScreen(),
    const TasksScreen(),
    const ListsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
      child: _pages[_selectedIndex],
    );
  }
}
