import 'package:dream_flow/screens/financial/widgets/transactions.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/screens/financial/widgets/accounts.dart';
import 'package:dream_flow/screens/financial/widgets/balance.dart';
import 'package:dream_flow/screens/financial/widgets/header.dart';
import 'package:dream_flow/services/api_service.dart';
import 'package:dream_flow/utils/utils.dart';

class FinancialScreen extends StatelessWidget {
  const FinancialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchTransactions('https://flow.dreamake.com.br/api/transacoes'),
        builder: (context, snapshot) {
          // Gerencia as instâncias enquanto carrega
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          }

          // Obtém dados da API
          final financialFlow = snapshot.data!;

          // Obtém total do Saldo Atual
          final balance = formatCurrency(financialFlow['current']['total']);

          // Obtém contas do usuário
          final accounts = [
            {'name': 'Conta 1', 'balance': 1500.00},
            {'name': 'Conta 2', 'balance': 320.50},
            {'name': 'Conta 3', 'balance': 580.75},
          ];

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff18202b),
                  Color(0xff090c11),
                  Color.fromARGB(255, 211, 211, 211),
                  Color.fromARGB(255, 211, 211, 211),
                ],
                stops: [0.0, 0.36, 0.36, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const HeaderUserSection(),
                const SizedBox(height: 10),
                BalanceSection(balance: balance),
                const SizedBox(height: 10),
                AccountsSection(accounts: accounts),
                const SizedBox(height: 10),
                TransactionsSection(transactions: financialFlow['transactions']),
              ],
            ),
          );
        },
      ),
    );
  }
}
