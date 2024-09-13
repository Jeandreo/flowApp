import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const IconButton(
        onPressed: null,
        icon: Icon(Icons.menu),
      ),
      title: Image.asset('assets/logo.webp', height: 25),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(12.0), // Raio das bordas arredondadas
            child: Image.asset(
              'assets/user.jpg', // Caminho da imagem
              width: 40, // Largura da imagem
              height: 40, // Altura da imagem
              fit:
                  BoxFit.cover, // Ajusta a imagem para cobrir a área disponível
            ),
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}
