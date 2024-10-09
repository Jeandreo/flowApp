import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meu_financeiro_organizado/models/user_model.dart'; // Importar o UserModel

class HeaderUserSection extends StatefulWidget {
  const HeaderUserSection({super.key});

  @override
  State<HeaderUserSection> createState() => _HeaderUserSectionState();
}

class _HeaderUserSectionState extends State<HeaderUserSection> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Chama a função que carrega o nome do usuário ao inicializar o widget
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Usuário';
    });
  }

  Future<void> _logout() async {
    await UserModel.clearPreferences();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/user.jpg',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Boa tarde',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${userName ?? 'Usuário'}!', // Exibe o nome ou "Usuário" enquanto carrega
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(50, 0, 0, 0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              iconSize: 25,
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                _logout(); // Chama a função de logout
              },
            ),
          ),
        ],
      ),
    );
  }
}
