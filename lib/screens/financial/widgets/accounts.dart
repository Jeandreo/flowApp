// lib/widgets/accounts_section.dart
import 'package:flutter/material.dart';

class AccountsSection extends StatelessWidget {
  final List<Map<String, dynamic>> accounts;

  const AccountsSection({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return _buildAccountCard(account['name'], account['balance']);
        },
      ),
    );
  }

  Widget _buildAccountCard(String accountName, double balance) {
    return SizedBox(
      width: 150,
      child: Card(
        child: ListTile(
          title: Text(accountName),
          subtitle: Text('\$${balance.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}
