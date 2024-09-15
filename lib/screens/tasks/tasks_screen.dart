// lib/screens/dashboard.dart
import 'package:dream_flow/screens/financial/widgets/transactions.dart';
import 'package:dream_flow/theme/top_bar.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: TopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TransactionsSection(),
        ],
      ),
    );
  }
}
