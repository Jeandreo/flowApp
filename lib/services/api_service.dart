import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchTransactions() async {
  final response = await http.get(Uri.parse('https://flow.dreamake.com.br/api/transacoes'));

  if (response.statusCode == 200) {
    // Decodifica o JSON da resposta
    return json.decode(response.body);
  } else {
    throw Exception('Falha ao carregar as transações');
  }
}