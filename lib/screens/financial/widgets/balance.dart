import 'package:dream_flow/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BalanceSection extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  const BalanceSection({
    super.key,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  @override
  State<BalanceSection> createState() => _BalanceSectionState();
}

class _BalanceSectionState extends State<BalanceSection> {
  String? _balance;

  @override
  void initState() {
    super.initState();
    _fetchBalance(); // Carrega o saldo na inicialização
  }

  // Função para buscar o saldo via API
  Future<void> _fetchBalance() async {
    try {
      final response = await http.get(Uri.parse('${apiRoute()}/financeiro/balanco'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final double balanceValue = double.parse(data);
        setState(() {
          _balance = formatCurrency(balanceValue); // Formata o saldo
        });
      } else {
        throw Exception('Falha ao carregar o saldo');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(15, 0, 0, 0),
            blurRadius: 25,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(47, 38, 41, 67),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.savings,
                color: Color.fromARGB(221, 37, 39, 49),
                size: 23,
              ),
            ),
            title: Text(
              'Saldo Atual',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(
              widget.isVisible ? (_balance ?? 'Carregando...') : '******',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: IconButton(
              icon: Icon(
                widget.isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: widget.onToggleVisibility,
            ),
          ),
        ],
      ),
    );
  }
}
