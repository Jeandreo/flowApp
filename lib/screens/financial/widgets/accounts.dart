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
    // Carrega os dados da API
    _accountsFuture = fetchAccounts();
  }

  Future<List<Map<String, dynamic>>> fetchAccounts() async {
    // Busca as carteiras e cartoes do usuário
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
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma conta encontrada.'));
        }

        final accounts = snapshot.data!;

        return Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 200, // Ajuste a altura para acomodar os itens verticalmente
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return _buildAccountCard(account['institution_id'], account['name']);
            },
          ),
        );
      },
    );
  }

  String _getImageUrl(int institutionId) {
    return 'https://flow.dreamake.com.br/storage/instituicoes/$institutionId/logo-150px.jpg';
  }

  Widget _buildAccountCard(int institutionId, String accountName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
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
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                _getImageUrl(institutionId),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              accountName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(
              '******', // Mostra ou esconde o saldo
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
