import 'package:meu_financeiro_organizado/screens/_partials/card_shadow.dart';
import 'package:meu_financeiro_organizado/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelect extends StatefulWidget {
  const DateSelect({super.key});

  @override
  State<DateSelect> createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  DateTime selectedDate = DateTime.now();

  void _nextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    });
  }

  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define o locale como pt_BR para mostrar os meses em português
    String formattedDate =
        DateFormat('MMMM yyyy', 'pt_BR').format(selectedDate);

    return CardShadow(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: _previousMonth,
          ),
          Text(
            capitalize(formattedDate),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: _nextMonth,
          ),
        ],
      ),
    );
  }
}
