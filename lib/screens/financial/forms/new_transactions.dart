import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final VoidCallback onCancel;

  const TransactionForm({
    Key? key,
    required this.onCancel,
  }) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();

  static Future<void> showTransactionForm(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nova Transação"),
          content: SingleChildScrollView(
            child: TransactionForm(
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  String _transactionName = '';
  double _transactionAmount = 0.0;

  Future<void> _sendTransaction() async {
    // Simule o envio para a API
    await Future.delayed(Duration(seconds: 2)); // Simulação de atraso

    // Aqui você colocaria a lógica para enviar os dados para sua API
    // Por exemplo:
    // await http.post('sua-api-url', body: {'name': _transactionName, 'amount': _transactionAmount});
    print('Transação enviada: Nome: $_transactionName, Valor: $_transactionAmount');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nome da Transação',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome';
              }
              return null;
            },
            onChanged: (value) {
              _transactionName = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Valor',
              prefixText: 'R\$ ',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um valor';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor, insira um número válido';
              }
              return null;
            },
            onChanged: (value) {
              _transactionAmount = double.tryParse(value) ?? 0.0;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      await _sendTransaction();
                      Navigator.of(context).pop();
                    } catch (error) {
                      // Lidar com erros de envio, por exemplo, mostrar uma mensagem de erro
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Erro"),
                            content: Text("Ocorreu um erro ao enviar a transação: $error"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Fechar"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: const Text("Salvar"),
              ),
              TextButton(
                onPressed: widget.onCancel,
                child: const Text("Cancelar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
