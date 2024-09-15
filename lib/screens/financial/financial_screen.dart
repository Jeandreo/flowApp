import 'package:flutter/material.dart';
import 'package:dream_flow/screens/financial/widgets/transactions.dart';
import 'package:dream_flow/screens/financial/widgets/accounts.dart';
import 'package:dream_flow/screens/financial/widgets/balance.dart';
import 'package:dream_flow/screens/financial/widgets/header.dart';

class FinancialScreen extends StatelessWidget {
  const FinancialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff18202b),
              Color(0xff090c11),
              Color.fromARGB(255, 211, 211, 211),
              Color.fromARGB(255, 211, 211, 211),
            ],
            stops: [0.0, 0.29, 0.29, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Column(
          children: [
            HeaderUserSection(),
            BalanceSection(balance: "R\$ 0,00"),
            SizedBox(height: 5),
            AccountsSection(),
            SizedBox(height: 15),
            TransactionsSection(),
          ],
        ),
      ),
    );
  }
}
