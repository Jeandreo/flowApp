import 'package:flutter/material.dart';
import 'package:dream_flow/utils/utils.dart'; // Supondo que o formatCurrency esteja aqui

class TransactionsSection extends StatelessWidget {
  final List<dynamic> transactions;

  const TransactionsSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              blurRadius: 25,
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
                    transaction['value'],
                    transaction['category'],
                    transaction['category_color'],
                    transaction['father_icon'],
                    transaction['fature'],
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
    String value,
    String? category,
    String? categoryColor,
    String? iconName,
    int fature,
  ) {
    // Formata o valor para exibição
    final formattedAmount = formatCurrency(double.tryParse(value) ?? 0.0);

    // Lógica para ajustar a categoria e ícone quando fature for 1
    final displayCategory = fature == 1 ? 'Fatura' : category;
    final displayCategoryColor = fature == 1
        ? Colors.orange
        : Color(
            int.parse(categoryColor!.substring(1, 7), radix: 16) + 0xFF000000);
    final displayIcon =
        fature == 1 ? Icons.receipt : _getIconForTransaction(iconName);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: displayCategoryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              displayIcon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
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
                Text(
                  displayCategory!,
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
