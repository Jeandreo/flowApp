import 'package:flutter/material.dart';

class IndicatorClose extends StatelessWidget {
  const IndicatorClose({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 5,
        width: 40,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(20, 0, 0, 0),
          borderRadius: BorderRadius.circular(10),
        ),
      );
  }
}