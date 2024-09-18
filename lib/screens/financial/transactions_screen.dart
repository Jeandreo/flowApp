import 'package:dream_flow/theme/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/screens/financial/widgets/transactions.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBar(),
      body: TransactionsSection(),
    );
  }
}