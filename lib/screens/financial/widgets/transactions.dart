// lib/widgets/transactions_section.dart
import 'package:dream_flow/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionsSection extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionsSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
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
      ),
    );
  }

  Widget _buildTransactionItem(String description, double amount) {

  // Formata o valor para a exibição
  final formattedAmount = formatCurrency(amount);

    return ListTile(
      title: Text(description),
      trailing: Text(
        formattedAmount,
        style: TextStyle(
          color: amount >= 0 ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
