import 'package:dream_flow/services/api_service.dart';
import 'package:dream_flow/services/transaction_service.dart';
import 'package:dream_flow/theme/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/utils/utils.dart';
import 'package:intl/intl.dart';

class TransactionsSection extends StatefulWidget {
  const TransactionsSection({super.key, required this.isVisible});
  final bool isVisible;

  @override
  State<TransactionsSection> createState() => _TransactionsSectionState();
}

class _TransactionsSectionState extends State<TransactionsSection> {
  late Future<List<dynamic>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = requestApi('${apiRoute()}/financeiro/transacoes').then((data) => data['transactions'] as List<dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma transação encontrada.'));
          }
          final transactions = snapshot.data!;
          return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Dismissible(
                  key: Key(transaction['id'].toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.green,
                      child: const Icon(Icons.check, color: Colors.white)),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await markAsPaid(transaction['id']);
                    }
                    return false;
                  },
                  child: _buildTransactionItem(
                      transaction['id'],
                      transaction['name'],
                      transaction['value'],
                      transaction['date_payment'],
                      transaction['color'],
                      transaction['icon'],
                      transaction['paid'] == 1,
                      transaction['fature'],
                      widget.isVisible),
                );
              });
        });
  }

  Widget _buildTransactionItem(
      int transactionId,
      String name,
      String value,
      String datePayment,
      String? fatherColor,
      String? iconName,
      bool isPaid,
      int fature,
      bool isVisible) {
    String money;
    Color color;
    if (isVisible) {
      money = formatCurrency(double.tryParse(value) ?? 0.0);
      color = double.parse(value) >= 0 ? Colors.green : Colors.red;
    } else {
      money = '*****';
      color = Colors.black;
    }
    final formattedDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(datePayment));
    final displayFatherColor = fature == 1
        ? Colors.orange
        : Color(
            int.parse(fatherColor!.substring(1, 7), radix: 16) + 0xFF000000);
    final displayIcon = fature == 1 ? Icons.receipt : getIconAwsome(iconName);
    return GestureDetector(
      onTap: () async {
        try {
          final transactionDetails =
              await fetchTransactionDetails(transactionId);
          if (!mounted) return;
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            builder: (context) {
              return TransactionForm(
                transactionId: transactionDetails['id'],
                transactionName: transactionDetails['name'],
                transactionValue: transactionDetails['value'],
                transactionDate: transactionDetails['date_payment'],
                isPaid: transactionDetails['paid'] == 1,
              );
            },
          );
        } catch (error) {
          print(error);
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: displayFatherColor, shape: BoxShape.circle),
              child: Icon(displayIcon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                        child: Text(name,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis))
                  ]),
                  Text(formattedDate,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(money,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: color)),
                Row(children: [
                  if (isPaid) ...[
                    const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: CircleAvatar(
                                  radius: 3, backgroundColor: Colors.green)),
                          SizedBox(width: 5),
                          Text('pago',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal)),
                        ]),
                  ] else ...[
                    const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: CircleAvatar(
                                  radius: 3, backgroundColor: Colors.red)),
                          SizedBox(width: 5),
                          Text('não pago',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal)),
                        ]),
                  ],
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
