import 'package:flutter/material.dart';

class GradientContainerVertical extends StatelessWidget {
  final Widget child;

  const GradientContainerVertical({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 108, 209),
            Color.fromARGB(255, 23, 0, 105),
          ],
          stops: [0, 1],
          begin: Alignment.topRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: child,
    );
  }
}
