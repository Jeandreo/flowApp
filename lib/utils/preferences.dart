import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static const String balanceVisibilityKey = 'isBalanceVisible';

  // Salva a visibilidade do saldo
  static Future<void> saveBalanceVisibility(bool isVisible) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(balanceVisibilityKey, isVisible);
  }

  // Carrega a visibilidade do saldo
  static Future<bool> getBalanceVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(balanceVisibilityKey) ?? false;
  }
}