import 'dart:convert';

import 'package:flutter/material.dart';

import '../../ui/widgets/adote_button.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String _selectedAge = 'recém-nascido';
  String _selectedCategory = '';
  List<String> _categories = [];

  List<String> _ages = [
    'recém-nascido',
    '1 ano',
    '2 anos',
    '3 anos',
    '4 anos',
    '5 anos',
    '6 anos',
    '7 anos',
    '8 anos',
    '9 anos',
    '10 anos',
    '11 anos',
    '12 anos',
    '13 anos',
    '14 anos',
    '15 anos',
    '16 anos',
    '17 anos',
    '18 anos',
    '19 anos',
    '20 anos',
    '21 anos',
    '22 anos',
    '23 anos',
    '24 anos',
    '25 anos',
  ];

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Chama a função para buscar as categorias da API ao iniciar a tela
  }

  Future<void> _fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://192.168.15.64:8080/animal-types'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> categories = [];

      for (var category in data) {
        categories.add(category['animalTypes']);
      }

      setState(() {
        _categories = categories;
        _selectedCategory = _categories.isNotEmpty
            ? _categories[0]
            : '';
      });
    } else {
      throw Exception('Falha ao carregar as categorias da API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Iserir seu pet no App'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  const SizedBox(height: 30),
                  Text('Idade:'),
                  DropdownButton<String>(
                    value: _selectedAge,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedAge = newValue!;
                      });
                    },
                    items: _ages.map((String age) {
                      return DropdownMenuItem<String>(
                        value: age,
                        child: Text(age),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text('Categoria:'),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  AdoteButton(
                    width: double.infinity,
                    label: 'Postar',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
