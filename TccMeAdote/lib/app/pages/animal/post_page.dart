import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc_me_adote/app/services/image_picker_service.dart';
import '../../data/http/http_client.dart';
import '../../data/models/animal_type_model.dart';
import '../../data/models/breeds_model.dart';
import '../../data/repositories/animal_type_repository.dart';
import '../../data/repositories/breeds_repository.dart';
import '../../services/firebase_storage_service.dart';
import '../../ui/widgets/adote_button.dart';
import 'dart:io';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String _selectedAge = 'recém-nascido';
  late String _selectedCategory;
  List<String> _categories = [];
  List<BreedsModel> _breeds = [];
  String _selectedBreed = '';
  late int _selectedCategoryId;
  late TextEditingController _descriptionController;
  ImagePickerService _imagePickerService = ImagePickerService();
  FirebaseStorageService _firebaseStorageService = FirebaseStorageService();
  List<XFile> _selectedImages = [];

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
    _selectedCategoryId = 1;
    _fetchBreeds(_selectedCategoryId);
    _descriptionController = TextEditingController();
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

  Future<void> _fetchBreeds(int categoryId) async {
    try {
      final repository = BreedsRepository(client: HttpClient());
      List<BreedsModel> breeds = await repository.getBreeds(categoryId);

      setState(() {
        _breeds = breeds;
        if (_breeds.isNotEmpty) {
          _selectedBreed = _breeds[0].breedName;
        }
      });
    } catch (e) {
      print('Erro ao carregar as raças: $e');
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _buildUploadButton() {
    return Center(
      child: Container(
        width: 320,
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color(0xFF3292FF),
            width: 2.0,
          ),
          color: Color(0xFFF3F3F3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              color: Color(0xFF3292FF),
              iconSize: 50,
              onPressed: () async {
                try {
                  List<XFile>? pickedFiles =
                      await _imagePickerService.pickImages();

                  if (pickedFiles != null && pickedFiles.isNotEmpty) {
                    setState(() {
                      _selectedImages = pickedFiles;
                    });
                  } else {
                    print('Nenhuma imagem selecionada.');
                  }
                } catch (e) {
                  print('Erro durante o processo de seleção das imagens: $e');
                }
              },
            ),
            const SizedBox(height: 5),
            Text(
              'Incluir fotos',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF3292FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedImages() {
    List<Widget> imageWidgets = _selectedImages.map((image) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.file(
            File(image.path),
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList();

    if (_selectedImages.isNotEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...imageWidgets,
            _buildUploadButton(),
          ],
        ),
      );
    } else {
      return Center(child: _buildUploadButton());
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
                      _buildSelectedImages(),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Nome'),
                      ),
                      const SizedBox(height: 30),
                      Text('Idade:'),
                      DropdownButton<String>(
                        isExpanded: true,
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
                      const SizedBox(height: 30),
                      Text('Categoria:'),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                            _selectedCategoryId =
                                (_selectedCategory == 'Cachorro') ? 1 : 2;
                            _fetchBreeds(_selectedCategoryId);
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
                      Text('Raça:'),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedBreed,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBreed = newValue!;
                          });
                        },
                        items: _breeds.map((BreedsModel breed) {
                          return DropdownMenuItem<String>(
                            value: breed.breedName,
                            child: Text(breed.breedName),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Descrição do Animal',
                          hintText: 'Digite uma breve descrição',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 30),
                      AdoteButton(
                        width: double.infinity,
                        label: 'Postar',
                        onPressed: () async {
                          try {
                            if (_selectedImages.isNotEmpty) {
                              String storagePath = 'postImages';
                              List<File> imageFiles = _selectedImages
                                  .map((xFile) => File(xFile.path))
                                  .toList();
                              List<String> imageUrls =
                                  await _firebaseStorageService.uploadImages(
                                      imageFiles, storagePath);
                              print('URLs das imagens: $imageUrls');
                            } else {
                              print('Nenhuma imagem selecionada.');
                            }
                          } catch (e) {
                            print('Erro ao postar: $e');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
