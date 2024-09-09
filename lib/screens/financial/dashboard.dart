// lib/screens/dashboard.dart
import 'package:dream_flow/screens/financial/widgets/accounts.dart';
import 'package:dream_flow/screens/financial/widgets/balance.dart';
import 'package:dream_flow/screens/financial/widgets/transactions.dart';
import 'package:dream_flow/theme/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      {'name': 'Conta 1', 'balance': 1500.00},
      {'name': 'Conta 2', 'balance': 320.50},
      {'name': 'Conta 3', 'balance': 580.75},
      // Adicione mais contas conforme necessário
    ];

    final transactions = [
      {'description': 'Compra ABaaC', 'amount': -50.00},
      {'description': 'Depósito XYZ', 'amount': 200.00},
      {'description': 'Pagamento DEF', 'amount': -30.00},
      // Adicione mais transações conforme necessário
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          BalanceSection(balance: 1234.56),
          const SizedBox(height: 5.0),
          AccountsSection(accounts: accounts),
          const SizedBox(height: 5.0),
          TransactionsSection(transactions: transactions),
        ],
      ),
    );
  }
}
