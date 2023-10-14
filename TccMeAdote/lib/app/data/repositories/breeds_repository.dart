import 'dart:convert';

import 'package:tcc_me_adote/app/data/http/http_client.dart';
import 'package:tcc_me_adote/app/data/models/breeds_model.dart';


abstract class IBreedsRepository {
  Future<List<BreedsModel>> getBreeds();
}

class BreedsRepository {
  final IHttpClient client;

  BreedsRepository({required this.client});

  @override
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
}