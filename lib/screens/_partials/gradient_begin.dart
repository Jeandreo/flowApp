import 'package:flutter/material.dart';

class GradientBegin extends StatelessWidget {
  final Widget child;

  const GradientBegin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff18202b),
            Color(0xff090c11),
            Color.fromARGB(255, 211, 211, 211),
            Color.fromARGB(255, 211, 211, 211),
          ],
          stops: [0.0, 0.25, 0.25, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
