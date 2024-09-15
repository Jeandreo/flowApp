import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  // Método para converter o JSON em um objeto UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['token'],
    );
  }

  // Método para salvar o usuário e o token no SharedPreferences
  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    await prefs.setString('userName', name);
    await prefs.setString('userEmail', email);
  }

  // Método para carregar o usuário e o token do SharedPreferences
  static Future<UserModel?> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final name = prefs.getString('userName');
    final email = prefs.getString('userEmail');

    if (token != null && name != null && email != null) {
      return UserModel(id: 0, name: name, email: email, token: token); // Ajuste o id conforme necessário
    }

    return null; // Se não houver dados salvos
  }

  // Método para limpar o SharedPreferences ao fazer logout
  static Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
