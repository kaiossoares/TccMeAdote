import 'dart:convert';

import 'package:tcc_me_adote/app/data/http/exceptions.dart';
import 'package:tcc_me_adote/app/data/http/http_client.dart';
import 'package:tcc_me_adote/app/data/models/animal_type_model.dart';

abstract class IAnimalTypeRepository {
  Future<List<AnimalTypeModel>> getAnimalTypes();
}

class AnimalTypeRepository implements IAnimalTypeRepository {
  final IHttpClient client;

  AnimalTypeRepository({required this.client});

  @override
  Future<List<AnimalTypeModel>> getAnimalTypes() async {
    final response =
        await client.get(url: 'https://tcc-meadote-api-062678c8588e.herokuapp.com/animal-types');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['animalTypes'];
      List<AnimalTypeModel> animalTypes = [];

      for (var item in data) {
        final AnimalTypeModel animalType = AnimalTypeModel.fromMap(item);
        animalTypes.add(animalType);
      }

      return animalTypes;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida!');
    } else {
      throw Exception('Falha ao carregar os tipos de animais da API');
    }
  }
}
