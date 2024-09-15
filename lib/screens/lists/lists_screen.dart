import 'package:dream_flow/screens/financial/widgets/accounts.dart';
import 'package:dream_flow/theme/top_bar.dart';
import 'package:flutter/material.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: TopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountsSection(),
        ],
      ),
    );
  }
}
