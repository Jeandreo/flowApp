import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> login(String email, String password) async {

  // URL para login no Flow
  final url = Uri.parse('https://flow.dreamake.com.br/api/login');
  
  // Tente
  try {
    // Requisição POST com email e senha no corpo da requisição
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Decodifica o JSON e extrai o token
      final responseData = json.decode(response.body);
      final token = responseData['token'];

      // Armazena o token localmente usando SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);

      print('Login bem-sucedido. Token salvo.');
    } else {
      print('Falha no login: ${response.body}');
    }
  } catch (e) {
    print('Erro: $e');
  }
}


Future<Map<String, dynamic>> fetchTransactions(String url) async {
  // Obtém o token armazenado
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  if (token == null) {
    throw Exception('Usuário não autenticado');
  }

  // Faz a requisição passando o token no cabeçalho Authorization
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',  // Token no cabeçalho
    },
  );

  if (response.statusCode == 200) {
    // Decodifica o JSON da resposta
    return json.decode(response.body);
  } else {
    throw Exception('Falha na requisição');
  }
}