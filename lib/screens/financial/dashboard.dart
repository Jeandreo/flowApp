import 'package:dream_flow/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/screens/financial/widgets/accounts.dart';
import 'package:dream_flow/screens/financial/widgets/balance.dart';
import 'package:dream_flow/screens/financial/widgets/transactions.dart';
import 'package:dream_flow/theme/custom_app_bar.dart';
import 'package:dream_flow/services/api_service.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchTransactions(),
        builder: (context, snapshot) {

          // Gerencia as intancias enquanto carrega
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          }

          // Obtém dados da API
          final financialFlow = snapshot.data!;
          final transactions = (financialFlow['transactions'] as List).map((transaction) => {
                                  'description': transaction['name'],
                                  'amount': double.parse(transaction['value']),
                                }).toList();

          // Obtém total do Saldo Atual
          final balance = formatCurrency(financialFlow['current']['total']);

          // Obtém contas do usuário
          final accounts = [
            {'name': 'Conta 1', 'balance': 1500.00},
            {'name': 'Conta 2', 'balance': 320.50},
            {'name': 'Conta 3', 'balance': 580.75},
          ];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              BalanceSection(balance: balance),
              const SizedBox(height: 5.0),
              AccountsSection(accounts: accounts),
              const SizedBox(height: 5.0),
              TransactionsSection(transactions: transactions),
            ],
          );
        },
      ),
    );
  }
}
