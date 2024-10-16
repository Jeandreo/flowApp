import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meu_financeiro_organizado/models/wallet_model.dart';
import 'package:meu_financeiro_organizado/screens/_partials/indicator_close.dart';
import 'package:meu_financeiro_organizado/utils/utils.dart';

class WalletsCredits extends StatefulWidget {
  final Function(int id, String name, String url, String type) onAccountSelected;
  const WalletsCredits({super.key, required this.onAccountSelected});
  @override
  State<WalletsCredits> createState() => _WalletsCreditsState();
}

class _WalletsCreditsState extends State<WalletsCredits> {
  List<dynamic> _walletsCredits = [];

  @override
  void initState() {
    super.initState();
    _loadWalletsCredits();
  }

  Future<void> _loadWalletsCredits() async {
    try {
      final walletsCredits = await _fetchWalletsCredits();
      setState(() {
        _walletsCredits = walletsCredits;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<List<WalletCreditModel>> _fetchWalletsCredits() async {
    final response = await http.get(Uri.parse('${apiRoute()}/financeiro/carteiras-e-cartoes'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => WalletCreditModel(
                id: data['id'],
                name: data['name'],
                type: data['type'],
                url: data['url'],
              ))
          .toList();
    } else {
      throw Exception('Falha ao carregar categorias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IndicatorClose(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          width: double.maxFinite,
          height: 470,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
              ),
              itemCount: _walletsCredits.length,
              itemBuilder: (BuildContext context, int index) {
                final walletsCredit =
                    _walletsCredits[index] as WalletCreditModel;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      int selectedId = walletsCredit.id;
                      String selectedName = walletsCredit.name;
                      String selectedUrl = walletsCredit.url;
                      String selectedType = walletsCredit.type;
                      widget.onAccountSelected(
                        selectedId,
                        selectedName,
                        selectedUrl,
                        selectedType,
                      );
                    });
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          walletsCredit.url,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 150,
                        constraints: const BoxConstraints(maxWidth: 60),
                        child: Text(
                          walletsCredit.name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        walletsCredit.type == 'wallet'
                            ? 'Carteira'
                            : 'Cartão de Crédito',
                            style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
