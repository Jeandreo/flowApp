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
        appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 153, 209),
                  Color.fromARGB(255, 0, 42, 147),
                  Color.fromARGB(250, 250, 250, 250),
                  Color.fromARGB(250, 250, 250, 250),
                ],
                stops: [0.0, 0.2, 0.2, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Column(
                  children: [
                    HeaderUserSection(),
                    BalanceSection(balance: "R\$ 0,00"),
                    SizedBox(height: 5),
                  ],
                ),
                const AccountsSection(),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(20, 0, 0, 0),
                        blurRadius: 25,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const TransactionsSection(),
                ))
              ],
            )));
  }
}
