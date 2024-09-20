import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/utils/utils.dart';
import 'package:dream_flow/screens/financial/widgets/categories.dart';
import 'package:dream_flow/screens/_partials/indicator_close.dart';

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

  Color? _selectedCategoryColor;
  String? _selectedCategoryIcon;
  String? _selectedCategoryName;

  @override
  void initState() {
    super.initState();
  }

  // Carrega o modal das categorias
  void _showCategoryDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Categories(
          onCategorySelected: (color, icon, name) {
            setState(() {
              _selectedCategoryColor = color;
              _selectedCategoryIcon = icon;
              _selectedCategoryName = name;
            });
          },
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
                        // _selectDate(context);
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
                              color: _selectedCategoryColor ?? Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _selectedCategoryIcon != null
                                  ? getIconAwsome(_selectedCategoryIcon!)
                                  : Icons.favorite,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            child: Text(
                              _selectedCategoryName ?? 'Selecione um ícone',
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
                      items: ['À vista', '2x', '3x', '4x', '5x']
                          .map((installment) {
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
                      items: ['Sim', 'Não'].map((recurrence) {
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
