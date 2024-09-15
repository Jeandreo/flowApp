import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountsSection extends StatefulWidget {
  const AccountsSection({super.key});

  @override
  _AccountsSectionState createState() => _AccountsSectionState();
}

class _AccountsSectionState extends State<AccountsSection> {
  late Future<List<Map<String, dynamic>>> _accountsFuture;

  @override
  void initState() {
    super.initState();
    _accountsFuture = fetchAccounts();
  }

  Future<List<Map<String, dynamic>>> fetchAccounts() async {
    final response = await http.get(Uri.parse(
        'https://flow.dreamake.com.br/api/financeiro/carteiras-e-cartoes'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load accounts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _accountsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma conta encontrada.'));
        }

        final accounts = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: accounts.map((account) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0), // Espaçamento horizontal
                child: SizedBox(
                  width: (MediaQuery.of(context).size.width - 30) / 2,
                  child: _buildAccountCard(
                    account['institution_id']!,
                    account['name']!,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Gera URL da imagem da instituição
  String _getImageUrl(int institutionId) {
    return 'https://flow.dreamake.com.br/storage/instituicoes/$institutionId/logo-150px.jpg';
  }

  Widget _buildAccountCard(int institutionId, String accountName) {
  return Container(
    height: 55, // Ajuste a altura conforme necessário
    padding: const EdgeInsets.all(8.0),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(30, 0, 0, 0),
          blurRadius: 25,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        // Imagem da instituição
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            _getImageUrl(institutionId),
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10), // Espaço entre a imagem e os textos

        // Textos (nome da conta e saldo)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
            children: [
              Text(
                accountName,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1, // Limita a 1 linha
                overflow: TextOverflow.ellipsis, // Adiciona "..." se o texto for maior que o espaço disponível
              ),
              Text(
                '******', // Placeholder para o saldo
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}
