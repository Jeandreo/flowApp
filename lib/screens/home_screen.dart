import 'package:flutter/material.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/transactions_screen.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/financial_screen.dart';
import 'package:meu_financeiro_organizado/screens/lists/lists_screen.dart';
import 'package:meu_financeiro_organizado/theme/bottom_navigation.dart';
import 'package:meu_financeiro_organizado/models/user_model.dart';

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
