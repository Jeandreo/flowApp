import 'package:flutter/material.dart';

class BalanceSection extends StatefulWidget {
  final String balance;

  const BalanceSection({super.key, required this.balance});

  @override
    State<BalanceSection> createState() => _BalanceSectionState();

}

class _BalanceSectionState extends State<BalanceSection> {
  bool _isBalanceVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(30, 0, 0, 0),
            blurRadius: 25,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(47, 38, 41, 67),
                borderRadius: BorderRadius.circular(
                    8),
              ),
              child: const Icon(
                Icons.savings,
                color: Color.fromARGB(221, 37, 39, 49),
                size: 23,
              ),
            ),
            title: Text(
              'saldo atual',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(
              _isBalanceVisible
                  ? widget.balance
                  : '******', // Mostra ou esconde o saldo
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: IconButton(
              icon: Icon(
                _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _isBalanceVisible = !_isBalanceVisible;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
