import 'package:meu_financeiro_organizado/components/auth_form.dart';
import 'package:meu_financeiro_organizado/screens/_partials/copyright.dart';
import 'package:meu_financeiro_organizado/screens/_partials/gradient_full_vertical.dart';
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
      body: GradientContainerVertical(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/logo.webp',
                height: 120,
                fit: BoxFit.contain,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    'FEITO  PARA VOCÊ CRESCER!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
                  child: Text(
                      'Inicie sua jornada e deixe suas tarefas, contas e agenda em um só lugar!',
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
