// lib/add_options_modal.dart
import 'package:dream_flow/theme/transaction_form.dart';
import 'package:flutter/material.dart';

class AddOptionsModal extends StatelessWidget {
  const AddOptionsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Indicador de arrastar
          Container(
            height: 5,
            width: 40,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
            child: Column(
              children: [
                Text(
                  'O que deseja adicionar?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 20),
                _buildOptionButton(Icons.add, 'Receita', Colors.green,
                    () => _showTransactionForm(context)),
                SizedBox(height: 10),
                _buildOptionButton(Icons.remove, 'Despesa', Colors.red, () {
                  // Ação para 'Despesa'
                }),
                SizedBox(height: 10),
                _buildOptionButton(Icons.transfer_within_a_station,
                    'Transferência', Colors.blue, () {
                  // Ação para 'Transferência'
                }),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: TransactionForm(),
        );
      },
    );
  }

  Widget _buildOptionButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        minimumSize: Size(double.infinity, 60),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
