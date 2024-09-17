import 'package:dream_flow/components/auth_form.dart';
import 'package:dream_flow/components/copyright.dart';
import 'package:dream_flow/components/gradient_full.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/financeiro'); // Navega para a página /dashboard
                  },
                  child: Image.asset(
                    'assets/logo.webp',
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    'PARA QUEM PERFORMAR!',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 26, color: Colors.white),
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
                          fontSize: 16)),
                ),
              ),
              const AuthForm(),
              const Spacer(),
              const Copyright(),
            ],
          ),
        ),
      ),
    );
  }
}
