import 'package:dream_flow/screens/financial/widgets/header.dart';
import 'package:dream_flow/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/screens/financial/widgets/accounts.dart';
import 'package:dream_flow/screens/financial/widgets/balance.dart';
import 'package:dream_flow/screens/financial/widgets/transactions.dart';
import 'package:dream_flow/services/api_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchTransactions('https://flow.dreamake.com.br/api/transacoes'),
        builder: (context, snapshot) {

          // Gerencia as instancias enquanto carrega
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
                const SizedBox(height: 50),
                const HeaderUserSection(),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:
                    Card(
                      child: Column(
                        children: [
                          BalanceSection(balance: balance),
                          AccountsSection(accounts: accounts),
                        ],
                      )
                    ),
                ),
                TransactionsSection(transactions: financialFlow['transactions']),
              ],
            ), 
          );
        },
      ),
    );
  }
}