import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          'WWW.SULINK.COM.BR',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
