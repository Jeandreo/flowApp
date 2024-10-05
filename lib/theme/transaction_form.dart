import 'dart:convert';
import 'package:dream_flow/screens/financial/widgets/walletsCredits.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dream_flow/utils/utils.dart';
import 'package:dream_flow/screens/financial/widgets/categories.dart';
import 'package:http/http.dart' as http;

class TransactionForm extends StatefulWidget {
  final Map<String, dynamic>? transaction;
  final String? transactionType;
  final int? transactionId;
  final bool isPaid;

  const TransactionForm({
    Key? key,
    this.transaction,
    this.transactionType,
    this.transactionId,
    this.isPaid = false,
  }) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController(text: 'R\$ 0,00');
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
    if (widget.transaction != null) {
      // Ajusta os principais dados da transação
      _descriptionController.text = widget.transaction!['name'] ?? '';
      _valueController.text = widget.transaction!['value'] ?? 'R\$ 0,00';
      _selectedDate = DateTime.parse(widget.transaction!['date_purchase']);
      _selectedCategoryId = widget.transaction!['category_id'];
      _selectedWalletId = widget.transaction!['wallet_id'];
      _selectedRecurrence =
          widget.transaction!['recurrent_id'] != null ? 'Sim' : 'Não';
      _observationController.text = widget.transaction!['description'] ?? '';

      // Ajusta as categorias
      var category = widget.transaction!['category'];
      if (category != null) {
        _selectedCategoryColor = Color(
            int.parse(category['color'].substring(1, 7), radix: 16) +
                0xFF000000);
        _selectedCategoryId = category['id'];
        _selectedCategoryIcon = category['icon'];
        _selectedCategoryName = category['name'];
      }

      // Ajusta as categorias
      var payment = widget.transaction!['payment'];
      if (payment != null) {
        _selectedWalletId = payment['id'];
        _selectedWalletName = payment['name'];
        _selectedWalletUrl = payment['url'];
        _selectedWalletType = payment['type'];
      }
    }
  }

  // Função que envia a transação para a API
  Future<void> _addTransaction() async {
    final transactionData = {
      'name': _descriptionController.text,
      'value': _valueController.text,
      'description': _observationController.text,
      'installments': _selectedInstallments,
      'recurrent': _selectedRecurrence,
      'date_purchase': _selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
          : null,
      'category_id': _selectedCategoryId,
      'method': _selectedWalletType,
      'method_id': _selectedWalletId,
      'type': widget.transactionType,
      'created_by': 1,
    };

    final url = Uri.parse('${apiRoute()}/financeiro/nova-transacao');

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
    // Define a cor do fundo
    Color bgValue;
    String textSend;

    // Realiza as verificações
    if (widget.transactionType == 'expense') {
      bgValue = Colors.red;
      textSend = 'adicionar despesa';
    } else if (widget.transactionType == 'transfer') {
      bgValue = Colors.black;
      textSend = 'realizar transferencia';
    } else {
      bgValue = const Color(0xff017a48);
      textSend = 'adicionar receita';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: bgValue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.calculate_rounded,
                color: Colors.white,
                size: 40,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'valor',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _valueController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'R\$ 0,00',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        filled: false,
                        contentPadding: const EdgeInsets.all(0),
                      ),
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
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descrição:',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextField(
                        controller: _descriptionController,
                      ),
                    ],
                  )),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pago com:',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 7),
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
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.circular(10),
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
                                : DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate!),
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
                        const SizedBox(height: 12),
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
                                  transactionType: widget.transactionType,
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      _selectedCategoryColor ?? Colors.black26,
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
                                  _selectedCategoryName ??
                                      'Selecione uma opção',
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
                          style: Theme.of(context).textTheme.titleSmall,
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
                          style: Theme.of(context).textTheme.titleSmall,
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
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  side:
                      const BorderSide(color: Color.fromARGB(255, 6, 137, 197)),
                  minimumSize: const Size(double.infinity, 60),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  backgroundColor: const Color.fromARGB(255, 6, 148, 209),
                  elevation: 0,
                ),
                onPressed: () {
                  _addTransaction();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textSend,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
