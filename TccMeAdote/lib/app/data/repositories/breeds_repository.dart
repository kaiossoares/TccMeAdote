import 'dart:convert';

import 'package:tcc_me_adote/app/data/http/http_client.dart';
import 'package:tcc_me_adote/app/data/models/breeds_model.dart';


abstract class IBreedsRepository {
  Future<List<BreedsModel>> getBreeds();
}

class BreedsRepository {
  final IHttpClient client;

  BreedsRepository({required this.client});

  Future<List<BreedsModel>> getBreeds(int categoryId) async {
    final response = await client.get(url: 'http://192.168.15.64:8080/breeds/$categoryId');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      List<BreedsModel> breeds = data.map((item) => BreedsModel.fromMap(item)).toList();
      return breeds;
    } else {
      throw Exception('Falha ao carregar as raças da API');
    }
  }

  Future<int> getBreedId(String breedName, int animalTypeId) async {
    final response = await client.get(url: Uri.encodeFull('http://192.168.15.64:8080/breeds/$breedName/$animalTypeId'));
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        int breedId = data['id'];
        print(breedId);
        return breedId;
      } else {
        throw Exception('Falha ao obter breedId da API. Código de status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro: $error');
    }
  }

}