import 'package:flutter/material.dart';

class BalanceSection extends StatelessWidget {
  final String balance;

  const BalanceSection({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        child: ListTile(
          title: const Text(
            'Saldo Atual',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          subtitle: Text(
            balance,  // Exibe o valor formatado
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
