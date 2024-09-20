import 'package:dream_flow/screens/_partials/indicator_close.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dream_flow/utils/utils.dart';
import 'dart:convert';

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
  String? _selectedCategory;
  List<dynamic> _categories = [];
  final List<String> _installments = ['À vista', '2x', '3x', '4x', '5x'];
  final List<String> _recurrences = ['Sim', 'Não'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _fetchCategories();
      setState(() {
        _categories = categories;
        print(categories);
      });
    } catch (error) {
      // Exiba uma mensagem de erro se necessário
    }
  }

  Future<List<dynamic>> _fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://flow.dreamake.com.br/api/financeiro/categorias'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar categorias');
    }
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

  void _showCategoryDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            IndicatorClose(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              width: double.maxFinite,
              height: 470, // Defina uma altura máxima
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: _categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = _categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['name'].toString();
                      });
                      Navigator.of(context).pop(); // Fecha o dialog
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(int.parse(
                                    category['color']!.substring(1, 7),
                                    radix: 16) +
                                0xFF000000),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            getIconAwsome(category['icon'].toString()),
                            color: Colors.white,
                            size: 25, // Tamanho do ícone
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          constraints: BoxConstraints(maxWidth: 60),
                          child: Text(
                            category['name'].toString(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center, // Alinha ao centro
            child: IndicatorClose(),
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pago Com',
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
                        String formattedValue = forceFormatCurrency(value);
                        _valueController.value = TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                              offset: formattedValue.length),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _showCategoryDialog(context);
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            child: Text(
                              _selectedCategory ?? 'Selecione um ícone',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

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
              SizedBox(width: 16),
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
            maxLines: 2,
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Adicione a ação desejada aqui
              },
              child: Text('Sa2lvar'),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
