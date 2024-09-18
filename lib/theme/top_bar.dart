import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const IconButton(
        onPressed: null,
        icon: Icon(Icons.menu),
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/financeiro');
        },
        child: Image.asset(
          'assets/images/logo.webp',
          height: 25,
          fit: BoxFit.contain,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/images/user.jpg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}
