import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 108, 209),
            Color.fromARGB(255, 2, 39, 123),
          ],
          stops: [0, 1],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: child,
    );
  }
}
