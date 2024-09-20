import 'package:dream_flow/models/wallet_model.dart';
import 'package:dream_flow/screens/_partials/indicator_close.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletsCredits extends StatefulWidget {
  final Function(String name, String url) onAccountSelected;
  const WalletsCredits({super.key, required this.onAccountSelected});
  @override
  State<WalletsCredits> createState() => _WalletsCreditsState();
}

class _WalletsCreditsState extends State<WalletsCredits> {
  List<dynamic> _walletsCredits = [];

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

  // Gera URL da imagem da instituição
  String _getImageUrl(int institutionId) {
    return 'https://flow.dreamake.com.br/storage/instituicoes/$institutionId/logo-150px.jpg';
  }

  Future<List<WalletCreditModel>> _fetchWalletsCredits() async {
    final response = await http.get(Uri.parse(
        'https://flow.dreamake.com.br/api/financeiro/carteiras-e-cartoes'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => WalletCreditModel(
                id: data['id'],
                name: data['name'],
                url: _getImageUrl(data['institution_id']),
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
        IndicatorClose(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          width: double.maxFinite,
          height: 470,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: _walletsCredits.length,
              itemBuilder: (BuildContext context, int index) {
                final walletsCredit =
                    _walletsCredits[index] as WalletCreditModel;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      String selectedName = walletsCredit.name;
                      String selectedUrl = walletsCredit.url;
                      widget.onAccountSelected(
                        selectedName,
                        selectedUrl,
                      );
                    });
                    Navigator.of(context).pop(); // Fecha o dialog
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
                        constraints: BoxConstraints(maxWidth: 60),
                        child: Text(
                          walletsCredit.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
