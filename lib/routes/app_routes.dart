import 'package:dream_flow/screens/auth/login.dart';
import 'package:dream_flow/screens/catalogs/catalogs.dart';
import 'package:dream_flow/screens/financial/dashboard.dart';
import 'package:dream_flow/screens/tasks/tasks.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String tasks = '/tarefas';
  static const String lists = '/listas';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case lists:
        return MaterialPageRoute(builder: (_) => const Catalogs());
      case tasks:
        return MaterialPageRoute(builder: (_) => const Tasks());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
