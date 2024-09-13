import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Função de login simulada
  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Aqui você pode adicionar a lógica de autenticação, como uma chamada à API
    if (email.isNotEmpty && password.isNotEmpty) {
      print('Email: $email');
      print('Password: $password');
      // Chame a API de autenticação aqui
    } else {
      print('Por favor, preencha todos os campos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ 
              Color(0xff18202b),
              Color(0xff090c11),  
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Espaço para empurrar o rodapé para o fim da tela
              const Spacer(),
              Padding(padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/logo.webp',
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    'PARA QUEM PERFORMAR!',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 26,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: Text(
                    'Inicie sua jornada e deixe suas tarefas, financeiro e agenda em um só lugar!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16
                    )
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email',
                  border: InputBorder.none, // Remove a borda
                  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0), 
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)), // Bordas arredondadas
                    borderSide: BorderSide.none, // Remove a borda externa
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)), // Bordas arredondadas
                    borderSide: BorderSide.none, // Remove a borda ao focar
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Senha',
                  border: InputBorder.none, // Remove a borda
                  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0), // Aumenta o tamanho do input
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)), // Bordas arredondadas
                    borderSide: BorderSide.none, // Remove a borda externa
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)), // Bordas arredondadas
                    borderSide: BorderSide.none, // Remove a borda ao focar
                  ),
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Entrar'),
              ),

              // Espaço para empurrar o rodapé para o fim da tela
              const Spacer(),

              // Barra de footer com o texto
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'sulink.com.br',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, // Cor do texto
                      fontSize: 14, // Tamanho da fonte
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
