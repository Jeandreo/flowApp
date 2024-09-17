import 'package:intl/intl.dart';

// Função utilitária para formatar valores monetários
String formatCurrency(num amount) {
  final doubleAmount = amount.toDouble();  // Converte para double
  return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(doubleAmount);
}

String capitalize(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}