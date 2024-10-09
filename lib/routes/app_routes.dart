import 'package:meu_financeiro_organizado/screens/auth/login.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/financial_screen.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/transactions_screen.dart';
import 'package:meu_financeiro_organizado/screens/home_screen.dart';
import 'package:meu_financeiro_organizado/screens/lists/lists_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String homescren = '/inicio';
  static const String financial = '/financeiro';
  static const String transactions = '/transacoes';
  static const String tasks = '/tarefas';
  static const String lists = '/listas';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homescren:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case financial:
        return MaterialPageRoute(builder: (_) => const FinancialScreen());
      case transactions:
        return MaterialPageRoute(builder: (_) => const TransactionsScreen());
      case lists:
        return MaterialPageRoute(builder: (_) => const ListsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
