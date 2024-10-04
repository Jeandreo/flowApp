import 'package:flutter/material.dart';

class BalanceSection extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  const BalanceSection({
    super.key,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(15, 0, 0, 0),
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.savings,
                color: Color.fromARGB(221, 37, 39, 49),
                size: 23,
              ),
            ),
            title: Text(
              'Saldo Atual',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(
              isVisible ? '123' : '******', // Mostra ou esconde o saldo
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: onToggleVisibility, // Chamando a função de alternância
            ),
          ),
        ],
      ),
    );
  }
}
