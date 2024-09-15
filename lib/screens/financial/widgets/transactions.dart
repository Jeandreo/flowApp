import 'package:flutter/material.dart';
import 'package:dream_flow/utils/utils.dart'; // Supondo que o formatCurrency esteja aqui

class TransactionsSection extends StatelessWidget {
  final List<dynamic> transactions;

  const TransactionsSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(10, 0, 0, 0),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return _buildTransactionItem(
                    transaction['name'],
                    transaction['category'],
                    transaction['category_color'],
                    transaction['value'],
                    transaction['father_icon'], // icone da transação
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    String name,
    String category,
    String categoryColor,
    String value,
    String? iconName,
  ) {
    // Formata o valor para exibição
    final formattedAmount = formatCurrency(double.parse(value));
    
    // Define uma cor de categoria
    final Color categoryColorParsed = Color(int.parse(categoryColor.substring(1, 7), radix: 16) + 0xFF000000);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Ícone grande à esquerda
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: categoryColorParsed.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconForTransaction(iconName),
              color: categoryColorParsed,
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          // Nome da transação e categoria
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Valor à direita
          Text(
            formattedAmount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: double.parse(value) >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // Função auxiliar para retornar um ícone baseado no nome
  IconData _getIconForTransaction(String? iconName) {
    // Coloque aqui a lógica para mapear o nome do ícone para um IconData
    // Por exemplo:
    switch (iconName) {
      case 'fa-solid fa-house-chimney':
        return Icons.home;
      default:
        return Icons.account_balance_wallet;
    }
  }
}
