import 'dart:convert';
import 'package:dream_flow/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // Variáveis responsáveis pela Autenticação
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  // Função de login
  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Se não forem preenchidas
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, preencha todos os campos';
      });
      return;
    }

    // Tente
    try {
      // Realiza autenticação
      final response = await http.post(
        Uri.parse('https://flow.dreamake.com.br/api/autenticacao/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      // Se a resposta for bem sucedido
      if (response.statusCode == 200) {
        // Decodifica o JSON e cria um objeto UserModel
        final responseData = json.decode(response.body);
        final user = UserModel.fromJson(responseData);

        // Armazena o token e informações do usuário localmente
        await user.saveToPreferences();

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/inicio');
      } else {
        setState(() {
          _errorMessage =
              json.decode(response.body)['message'] ?? 'Falha na autenticação';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'E-MAIL',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SENHA',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _passwordController,
          obscureText: true,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _login,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 255, 115, 0)),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            child: const Text('ACESSAR'),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ],
      ],
    ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
