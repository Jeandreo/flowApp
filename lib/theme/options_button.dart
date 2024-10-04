import 'package:dream_flow/screens/_partials/indicator_close.dart';
import 'package:dream_flow/theme/transaction_form.dart';
import 'package:flutter/material.dart';

class NavBottomOptionsModal extends StatefulWidget {
  const NavBottomOptionsModal({Key? key}) : super(key: key);

  @override
  State<NavBottomOptionsModal> createState() => _NavBottomOptionsModalState();
}

class _NavBottomOptionsModalState extends State<NavBottomOptionsModal> {
  String? _transactionType;

  // Abre o formulário de acordo com o tipo de transação
  void _showTransactionForm(BuildContext context, String transactionType) {
    setState(() {
      _transactionType = transactionType;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: TransactionForm(transactionType: _transactionType),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const IndicatorClose(),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
            child: Column(
              children: [
                Text(
                  'O que deseja adicionar?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                _buildOptionButton(
                  Icons.add,
                  'Receita',
                  Colors.green,
                  () => _showTransactionForm(context, 'revenue'),
                ),
                const SizedBox(height: 10),
                _buildOptionButton(
                  Icons.remove,
                  'Despesa',
                  Colors.red,
                  () => _showTransactionForm(context, 'expense'),
                ),
                const SizedBox(height: 10),
                _buildOptionButton(
                  Icons.transfer_within_a_station,
                  'Transferência',
                  Colors.blue,
                  () => _showTransactionForm(context, 'transfer'),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Formata os botões do footer
  Widget _buildOptionButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        minimumSize: const Size(double.infinity, 60),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: color, fontSize: 16),
          ),
          Icon(
            icon,
            color: color,
            size: 24,
          ),
        ],
      ),
    );
  }
}
