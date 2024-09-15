// lib/widgets/accounts_section.dart
import 'package:flutter/material.dart';

class AccountsSection extends StatelessWidget {
  final List<Map<String, dynamic>> accounts;

  const AccountsSection({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: 200, // Ajuste a altura para acomodar os itens verticalmente
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return _buildAccountCard(account['name'], account['balance']);
        },
      ),
    );
  }

  Widget _buildAccountCard(String accountName, double balance) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.network(
          'https://flow.dreamake.com.br/storage/instituicoes/1/logo-150px.jpg',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(accountName),
        subtitle: Text('\$${balance.toStringAsFixed(2)}'),
      ),
    );
  }
}
