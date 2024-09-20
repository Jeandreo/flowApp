import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _observationController = TextEditingController();

  String? _selectedInstallments;
  String? _selectedRecurrence;
  DateTime? _selectedDate;

  final List<String> _installments = ['À vista', '2x', '3x', '4x', '5x'];
  final List<String> _recurrences = ['Sim', 'Não'];

  @override
  void initState() {
    super.initState();
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Descrição:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          TextField(
            controller: _descriptionController,
          ),
          SizedBox(height: 16),

          // Método e Valor lado a lado
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Método:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valor:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextField(
                      controller: _valueController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        String formattedValue = _formatCurrency(value);
                        _valueController.value = TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(offset: formattedValue.length),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Data e Categoria lado a lado
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data da Compra:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: _selectedDate == null
                            ? 'Selecione uma data'
                            : 'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16), // Espaçamento entre Data e Categoria
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categoria:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Parcelamento e Recorrente lado a lado
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parcelamento:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedInstallments,
                      onChanged: (value) {
                        setState(() {
                          _selectedInstallments = value;
                        });
                      },
                      items: _installments.map((installment) {
                        return DropdownMenuItem(
                          value: installment,
                          child: Text(installment),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16), // Espaçamento entre Parcelamento e Recorrente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recorrente?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedRecurrence,
                      onChanged: (value) {
                        setState(() {
                          _selectedRecurrence = value;
                        });
                      },
                      items: _recurrences.map((recurrence) {
                        return DropdownMenuItem(
                          value: recurrence,
                          child: Text(recurrence),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          Text(
            'Observação:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          TextField(
            controller: _observationController,
            maxLines: 3,
          ),
          SizedBox(height: 16),

          Center(
            child: ElevatedButton(
              onPressed: () {
                // Adicione a ação desejada aqui
              },
              child: Text('Salvar'),
            ),
          ),
        ],
      ),
    );
  }

  // Função para formatar o valor para o formato de moeda brasileiro
  String _formatCurrency(String value) {
    value = value.replaceAll(RegExp(r'[^\d]'), '');
    if (value.isEmpty) return '';
    double parsedValue = double.parse(value) / 100;
    return NumberFormat.currency(locale: 'pt_BR', symbol: '').format(parsedValue);
  }
}
