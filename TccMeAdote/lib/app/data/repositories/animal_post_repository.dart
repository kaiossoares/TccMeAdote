import 'dart:convert';

import '../../services/auth_service.dart';
import '../http/http_client.dart';
import '../models/animal_post_model.dart';

abstract class IAnimalPostRepository {
  Future<AnimalPostModel> createAnimalPost(
      AnimalPostModel animalPost, List<String> photoUrls);
}

class AnimalPostRepository implements IAnimalPostRepository {
  final IHttpClient client;

  AnimalPostRepository({required this.client});

  @override
  Future<AnimalPostModel> createAnimalPost(
      AnimalPostModel animalPost, List<String> photoUrls) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'animalPost': {
        'animalName': animalPost.animalName,
        'animalTypeId': animalPost.animalTypeId,
        'breedId': animalPost.breedId,
        'sex': animalPost.sex,
        'age': animalPost.age,
        'description': animalPost.description,
        'userFirebaseUid': animalPost.userFirebaseUid,
      },
      'photoUrls': photoUrls,
    };

    final response = await client.post(
      url: 'http://192.168.15.64:8080/api/posts/post',
      headers: headers,
      body: requestBody,
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes));
      return AnimalPostModel.fromMap(data);
    } else {
      throw Exception('Falha ao criar post de animal na API');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAnimalPosts(int animalType) async {
    String url;
    String? userFirebaseUid = await AuthService().getUserFirebaseUid();

    try {
      if (animalType == 1) {
        url =
            'http://192.168.15.64:8080/api/posts/list/animal-type/1/$userFirebaseUid';
      } else if (animalType == 2) {
        url =
            'http://192.168.15.64:8080/api/posts/list/animal-type/2/$userFirebaseUid';
      } else {
        url = 'http://192.168.15.64:8080/api/posts/list/$userFirebaseUid';
      }

      final response = await client.get(url: url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        final List<Map<String, dynamic>> animalPosts =
            data.cast<Map<String, dynamic>>();
        return animalPosts;
      } else {
        print(
            'Erro ao carregar os dados da API - Status Code: ${response.statusCode}');
        throw Exception(
            'Falha ao carregar os dados da API - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar os dados da API: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFavoritesAnimalPosts() async {
    String url;
    String? userFirebaseUid = await AuthService().getUserFirebaseUid();

    try {
      url =
          'http://192.168.15.64:8080/api/posts/favorites-animal-posts/$userFirebaseUid';

      final response = await client.get(url: url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        final List<Map<String, dynamic>> animalPosts =
            data.cast<Map<String, dynamic>>();
        return animalPosts;
      } else {
        print(
            'Erro ao carregar os dados da API - Status Code: ${response.statusCode}');
        throw Exception(
            'Falha ao carregar os dados da API - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar os dados da API: $e');
      rethrow;
    }
  }
}
