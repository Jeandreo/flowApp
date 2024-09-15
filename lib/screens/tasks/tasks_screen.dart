// lib/screens/dashboard.dart
import 'package:dream_flow/screens/financial/widgets/transactions.dart';
import 'package:dream_flow/theme/top_bar.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final transactions = [
      {'description': 'Compra ABaaC', 'amount': -50.00},
      {'description': 'Depósito XYZ', 'amount': 200.00},
      {'description': 'Pagamento DEF', 'amount': -30.00},
    ];

    return Scaffold(
      appBar: const TopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TransactionsSection(transactions: transactions),
        ],
      ),
    );
  }
}
