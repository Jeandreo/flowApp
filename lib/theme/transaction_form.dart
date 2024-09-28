import 'dart:convert';
import 'package:dream_flow/screens/financial/widgets/walletsCredits.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/utils/utils.dart';
import 'package:dream_flow/screens/financial/widgets/categories.dart';
import 'package:dream_flow/screens/_partials/indicator_close.dart';
import 'package:http/http.dart' as http;

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _observationController = TextEditingController();

  String? _selectedInstallments;
  String? _selectedRecurrence;
  DateTime? _selectedDate;

  int? _selectedCategoryId;
  Color? _selectedCategoryColor;
  String? _selectedCategoryIcon;
  String? _selectedCategoryName;

  int? _selectedWalletId;
  String? _selectedWalletUrl;
  String? _selectedWalletName;
  String? _selectedWalletType;

  @override
  void initState() {
    super.initState();
  }

  // Função que envia a transação para a API
  Future<void> _addTransaction() async {
    final transactionData = {
      'description': _descriptionController.text,
      'value': _valueController.text,
      'observation': _observationController.text,
      'installments': _selectedInstallments,
      'recurrence': _selectedRecurrence,
      'date': _selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
          : null,
      'category': _selectedCategoryId,
      'payment': {
        'id': _selectedWalletId,
        'type': _selectedWalletType,
      },
    };

    final url = Uri.parse('https://flow.dreamake.com.br/api/financeiro/nova-transacao');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 201) {
        // Sucesso ao adicionar transação
        print('Transação adicionada com sucesso');
      } else {
        // Erro na requisição
        print('Erro ao adicionar transação: ${response.body}');
      }

    } catch (error) {
      print('Erro ao enviar requisição: $error');
    }
  }

  // Função para selecionar a data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
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
          const Align(
            alignment: Alignment.center,
            child: IndicatorClose(),
          ),
          Text(
            'Descrição:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _descriptionController,
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pago com:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return WalletsCredits(
                              onAccountSelected: (id, name, url, type) {
                                setState(() {
                                  _selectedWalletId = id;
                                  _selectedWalletName = name;
                                  _selectedWalletUrl = url;
                                  _selectedWalletType = type;
                                });
                              },
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            child: _selectedWalletUrl == null
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: _selectedCategoryColor ??
                                          Colors.black26,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(
                                      Icons.wallet,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      _selectedWalletUrl!,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 130,
                            child: Text(
                              _selectedWalletName ?? 'Selecione',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valor:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 5),
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
          const SizedBox(height: 10),
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
                    const SizedBox(height: 5),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: _selectedDate == null
                            ? '00/00/0000'
                            : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categoria:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Categories(
                              onCategorySelected: (id, color, icon, name) {
                                setState(() {
                                  _selectedCategoryId = id;
                                  _selectedCategoryColor = color;
                                  _selectedCategoryIcon = icon;
                                  _selectedCategoryName = name;
                                });
                              },
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _selectedCategoryColor ?? Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _selectedCategoryIcon != null
                                  ? getIconAwsome(_selectedCategoryIcon!)
                                  : Icons.list,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 130,
                            child: Text(
                              _selectedCategoryName ?? 'Selecione uma opção',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
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
          const SizedBox(height: 10),
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
                    const SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: _selectedInstallments,
                      hint: const Text('Não'),
                      onChanged: (value) {
                        setState(() {
                          _selectedInstallments = value;
                        });
                      },
                      items: ['Não', 'Sim'].map((installment) {
                        return DropdownMenuItem(
                          value: installment,
                          child: Text(installment),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recorrente?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: _selectedRecurrence,
                      hint: const Text('Não'),
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
          const SizedBox(height: 10),
          Text(
            'Observação:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _observationController,
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color.fromARGB(255, 143, 197, 6)),
              minimumSize: const Size(double.infinity, 60),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              backgroundColor: const Color.fromARGB(255, 152, 209, 6),
              elevation: 0,
            ),
            onPressed: () {
              _addTransaction();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Adicionar Transação',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
