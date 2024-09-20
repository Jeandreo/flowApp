import 'package:dream_flow/models/wallet_model.dart';
import 'package:dream_flow/screens/financial/widgets/walletsCredits.dart';
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

  String? _selectedWalletUrl;
  String? _selectedWalletName;

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

  // Carrega o modal das categorias
  void _showPaymentDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return WalletsCredits(
          onAccountSelected: (name, url) {
            setState(() {
              _selectedWalletName = name;
              _selectedWalletUrl = url;
              print(name);
              print(url);
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
            alignment: Alignment.center,
            child: IndicatorClose(),
          ),
          Text(
            'Descrição:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 5),
          TextField(
            controller: _descriptionController,
          ),
          SizedBox(height: 10),
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
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        _showPaymentDialog(context);
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
                                  : Icons.wallet,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 130,
                            child: Text(
                              _selectedWalletName ?? 'Selecione',
                              overflow: TextOverflow.ellipsis,
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
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valor:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 5),
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
          SizedBox(height: 10),
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
                    SizedBox(height: 5),
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
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categoria:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        _showCategoryDialog(context);
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
                          SizedBox(width: 8),
                          Container(
                            width: 130,
                            child: Text(
                              _selectedCategoryName ?? 'Selecione uma opção',
                              overflow: TextOverflow.ellipsis,
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
          SizedBox(height: 10),
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
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: _selectedInstallments,
                      hint: Text('Não'),
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
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recorrente?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: _selectedRecurrence,
                      hint: Text('Não'),
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
          SizedBox(height: 10),
          Text(
            'Observação:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 5),
          TextField(
            controller: _observationController,
            maxLines: 2,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: const Color.fromARGB(255, 143, 197, 6)),
              minimumSize: Size(double.infinity, 60),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              backgroundColor: const Color.fromARGB(255, 152, 209, 6),
              elevation: 0,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Adicionar Transação',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
