import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // P

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


String forceFormatCurrency(String value) {
  value = value.replaceAll(RegExp(r'[^\d]'), '');
  if (value.isEmpty) return '';
  double parsedValue = double.parse(value) / 100;
  return NumberFormat.currency(locale: 'pt_BR', symbol: '')
      .format(parsedValue);
}

IconData getIconAwsome(String? iconName) {
  switch (iconName) {
    case 'fa-solid fa-piggy-bank':
      return Icons.monetization_on;
    case 'fa-solid fa-house-chimney':
      return Icons.home;
    case 'fa-solid fa-drumstick-bite':
      return Icons.restaurant;
    case 'fa-solid fa-film':
      return Icons.movie;
    case 'fa-solid fa-heart-pulse':
      return Icons.favorite;
    case 'fa-solid fa-graduation-cap':
      return Icons.school;
    case 'fa-solid fa-scissors':
      return Icons.content_cut;
    case 'fa-solid fa-triangle-exclamation':
      return Icons.warning;
    case 'fa-solid fa-cart-flatbed':
      return Icons.shopping_cart;
    case 'fa-solid fa-road':
      return Icons.directions_car;
    default:
      return Icons.account_balance_wallet;
  }
}