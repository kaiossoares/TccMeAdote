import 'dart:convert';

import 'package:flutter/foundation.dart';

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
      url: 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/post',
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
            'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/list/animal-type/1/$userFirebaseUid';
      } else if (animalType == 2) {
        url =
            'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/list/animal-type/2/$userFirebaseUid';
      } else {
        url = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/list/$userFirebaseUid';
      }

      final response = await client.get(url: url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        final List<Map<String, dynamic>> animalPosts =
            data.cast<Map<String, dynamic>>();
        return animalPosts;
      } else {
        if (kDebugMode) {
          print(
            'Erro ao carregar os dados da API - Status Code: ${response.statusCode}');
        }
        throw Exception(
            'Falha ao carregar os dados da API - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os dados da API: $e');
      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFavoritesAnimalPosts() async {
    String url;
    String? userFirebaseUid = await AuthService().getUserFirebaseUid();

    try {
      url =
          'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/favorites-animal-posts/$userFirebaseUid';

      final response = await client.get(url: url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        final List<Map<String, dynamic>> animalPosts =
            data.cast<Map<String, dynamic>>();
        return animalPosts;
      } else {
        if (kDebugMode) {
          print(
            'Erro ao carregar os dados da API - Status Code: ${response.statusCode}');
        }
        throw Exception(
            'Falha ao carregar os dados da API - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os dados da API: $e');
      }
      rethrow;
    }
  }

  Future<void> deletePost(int postId) async {
    final url = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/delete/$postId';

    try {
      final response = await client.delete(url: url, body: {});
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Post excluído com sucesso');
        }
      } else {
        if (kDebugMode) {
          print('Falha ao excluir o post: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Erro durante a solicitação: $error');
      }
    }
  }

  Future<List<Map<String, dynamic>>> fetchPostById(int postId) async {
    String url = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/$postId';

    try {
      final response = await client.get(url: url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        final List<Map<String, dynamic>> posts = data.cast<Map<String, dynamic>>();
        return posts;
      } else {
        if (kDebugMode) {
          print('Erro ao carregar os dados da API - Status Code: ${response.statusCode}');
        }
        throw Exception('Falha ao carregar os dados da API - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os dados da API: $e');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPostByUserId(int postId) async {
    String url = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/user/$postId';

    try {
      final response = await client.get(url: url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> postData = json.decode(utf8.decode(response.bodyBytes));
        return postData;
      } else {
        if (kDebugMode) {
          print('Erro ao carregar os dados da API - Status Code: ${response.statusCode}');
        }
        throw Exception('Falha ao carregar os dados da API - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os dados da API: $e');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchReceiverUserData(String postId) async {
    String url = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/user/$postId';

    final response = await client.get(url: url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao obter dados do usuário');
    }
  }
}
