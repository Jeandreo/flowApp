import 'package:dream_flow/models/category_model.dart';
import 'package:dream_flow/screens/_partials/indicator_close.dart';
import 'package:dream_flow/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<dynamic> _categories = [];
  String? _selectedCategory;

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
      print(error);
    }
  }

  Future<List<CategoryModel>> _fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://flow.dreamake.com.br/api/financeiro/categorias'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => CategoryModel(
                id: data['id'],
                name: data['name'],
                icon: data['icon'] ?? '',
                color: data['color'] ?? '',
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
                final category = _categories[index] as CategoryModel;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category.name;
                      String selectedColor = category.color;
                      String selectedIcon = category.icon;
                      int selectedId = category.id;
                    });
                    Navigator.of(context).pop(); // Fecha o dialog
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(int.parse(category.color.substring(1, 7),
                                  radix: 16) +
                              0xFF000000),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          getIconAwsome(category.icon),
                          color: Colors.white,
                          size: 25, // Tamanho do ícone
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        constraints: BoxConstraints(maxWidth: 60),
                        child: Text(
                          category.name,
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
