import 'package:flutter/material.dart';
import 'package:dream_flow/screens/financial/transactions_screen.dart';
import 'package:dream_flow/screens/financial/financial_screen.dart';
import 'package:dream_flow/screens/tasks/tasks_screen.dart';
import 'package:dream_flow/screens/lists/lists_screen.dart';
import 'package:dream_flow/theme/bottom_navigation.dart';
import 'package:dream_flow/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FinancialScreen(),
    const TransactionsScreen(),
    const TasksScreen(),
    const ListsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  // Redireciona para a página de login se o usuário não estiver autenticado
  Future<void> _checkAuthStatus() async {
    final user = await UserModel.loadFromPreferences();
    if (user == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _checkAuthStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao verificar autenticação'));
          } else {
            return BottomNavigationLayout(
              currentIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              child: _pages[_selectedIndex],
            );
          }
        },
      ),
    );
  }
}
