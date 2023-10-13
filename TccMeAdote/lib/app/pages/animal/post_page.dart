import 'package:flutter/material.dart';
import '../../data/http/http_client.dart';
import '../../data/models/animal_type_model.dart';
import '../../data/repositories/animal_type_repository.dart';
import '../../ui/widgets/adote_button.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String _selectedAge = 'recém-nascido';
  late String _selectedCategory;
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
    _selectedCategory = '';
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final repository = AnimalTypeRepository(client: HttpClient());
      List<AnimalTypeModel> animalTypes = await repository.getAnimalTypes();

      setState(() {
        _categories = animalTypes.map((type) => type.animalTypes).toList();
        if (_categories.isNotEmpty) {
          _selectedCategory = _categories[0];
        }
      });
    } catch (e) {
      print('Erro ao carregar as categorias: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir seu pet no App'),
      ),
      body: _categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
            ),
    );
  }
}
