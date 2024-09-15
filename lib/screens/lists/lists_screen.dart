import 'package:dream_flow/screens/financial/widgets/accounts.dart';
import 'package:dream_flow/theme/top_bar.dart';
import 'package:flutter/material.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      {'name': 'Conta 1', 'balance': 1500.00},
      {'name': 'Conta 2', 'balance': 320.50},
      {'name': 'Conta 3', 'balance': 580.75},
      {'name': 'Conta 4', 'balance': 580.75},
      {'name': 'Conta 5', 'balance': 580.75},
      {'name': 'Conta 6', 'balance': 580.75},
      {'name': 'Conta 7', 'balance': 580.75},
    ];

    return Scaffold(
      appBar: const TopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountsSection(accounts: accounts),
        ],
      ),
    );
  }
}
