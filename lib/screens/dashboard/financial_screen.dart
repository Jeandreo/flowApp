import 'package:flutter/material.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/widgets/transactions.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/widgets/accounts.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/widgets/balance.dart';
import 'package:meu_financeiro_organizado/screens/dashboard/widgets/header.dart';
import 'package:meu_financeiro_organizado/utils/preferences.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  bool _isBalanceVisible = false;

  @override
  void initState() {
    super.initState();
    _loadBalanceVisibility();
  }

  // Carrega a visibilidade do saldo
  Future<void> _loadBalanceVisibility() async {
    bool isVisible = await PreferencesUtil.getBalanceVisibility();
    setState(() {
      _isBalanceVisible = isVisible;
    });
  }

  // Alterna a visibilidade do saldo
  void _toggleBalanceVisibility() {
    setState(() { _isBalanceVisible = !_isBalanceVisible; });
    PreferencesUtil.saveBalanceVisibility(_isBalanceVisible);
  }

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
                const HeaderUserSection(),
                BalanceSection(
                  isVisible: _isBalanceVisible,
                  onToggleVisibility: _toggleBalanceVisibility,
                ),
                const SizedBox(height: 5),
                AccountsSection(
                  isBalanceVisible: _isBalanceVisible,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                    child: TransactionsSection(
                      isVisible: _isBalanceVisible,
                    ),
                  ),
                ),
              ],
            )));
  }
}
