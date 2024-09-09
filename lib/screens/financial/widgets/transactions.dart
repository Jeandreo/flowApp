// lib/widgets/transactions_section.dart
import 'package:flutter/material.dart';

class TransactionsSection extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionsSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Transações Recentes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return _buildTransactionItem(
                    transaction['description'],
                    transaction['amount'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String description, double amount) {
    return ListTile(
      title: Text(description),
      trailing: Text(
        (amount >= 0 ? '+' : '-') + '\$${amount.abs().toStringAsFixed(2)}',
        style: TextStyle(
          color: amount >= 0 ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
