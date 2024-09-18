import 'package:flutter/material.dart';

class CardShadow extends StatelessWidget {
  final Widget child;

  const CardShadow({super.key, required this.child});

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
      child: child,
    );
  }
}
