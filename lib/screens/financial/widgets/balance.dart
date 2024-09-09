// lib/widgets/balance_section.dart
import 'package:flutter/material.dart';

class BalanceSection extends StatelessWidget {
  final double balance;

  const BalanceSection({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        child: ListTile(
          title: Text(
            'Saldo Atual',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            '\$${balance.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
