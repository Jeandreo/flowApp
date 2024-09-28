import 'package:flutter/material.dart';
import 'package:dream_flow/services/api_service.dart';
import 'package:dream_flow/utils/utils.dart';
import 'package:intl/intl.dart';

class TransactionsSection extends StatefulWidget {
  const TransactionsSection({super.key});
  @override
  State<TransactionsSection> createState() => _TransactionsSectionState();
}

class _TransactionsSectionState extends State<TransactionsSection> {
  late Future<List<dynamic>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = requestApi('https://flow.dreamake.com.br/api/financeiro/transacoes').then((data) => data['transactions'] as List<dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _transactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma transação encontrada.'));
        }

        final transactions = snapshot.data!;

        return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return _buildTransactionItem(
                transaction['name'],
                transaction['value'],
                transaction['date_payment'],
                transaction['color'],
                transaction['icon'],
                transaction['fature'],
              );
            },
          );
      },
    );
  }

  Widget _buildTransactionItem(
    String name,
    String value,
    String datePayment, // Recebe a data de pagamento
    String? fatherColor,
    String? iconName,
    int fature,
  ) {
    final formattedAmount = formatCurrency(double.tryParse(value) ?? 0.0);

    // Formatar a data de pagamento
    final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(datePayment));
    final displayfatherColor = fature == 1 ? Colors.orange : Color(int.parse(fatherColor!.substring(1, 7), radix: 16) + 0xFF000000);
    final displayIcon = fature == 1 ? Icons.receipt : getIconAwsome(iconName);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: displayfatherColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              displayIcon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Exibir a data de pagamento
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            formattedAmount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: double.parse(value) >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
