import 'package:dream_flow/screens/auth/login.dart';
import 'package:dream_flow/screens/financial/financial_screen.dart';
import 'package:dream_flow/screens/lists/lists_screen.dart';
import 'package:dream_flow/screens/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String financial = '/financeiro';
  static const String tasks = '/tarefas';
  static const String lists = '/listas';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case financial:
        return MaterialPageRoute(builder: (_) => const FinancialScreen());
      case lists:
        return MaterialPageRoute(builder: (_) => const ListsScreen());
      case tasks:
        return MaterialPageRoute(builder: (_) => const TasksScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
