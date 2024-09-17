import 'package:dream_flow/components/gradient_begin.dart';
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
      body: const GradientBegin(
        child: Column(
          children: [
            HeaderUserSection(),
            BalanceSection(balance: "R\$ 0,00"),
            SizedBox(height: 5),
            AccountsSection(),
            SizedBox(height: 10),
            TransactionsSection(),
          ],
        ),
      ),
    );
  }
}
