import 'dart:convert';

import '../http/http_client.dart';
import '../models/animal_post_model.dart';

abstract class IAnimalPostRepository {
  Future<AnimalPostModel> createAnimalPost(AnimalPostModel animalPost, List<String> photoUrls);
}

class AnimalPostRepository implements IAnimalPostRepository {
  final IHttpClient client;

  AnimalPostRepository({required this.client});

  @override
  Future<AnimalPostModel> createAnimalPost(AnimalPostModel animalPost, List<String> photoUrls) async {
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
      final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return AnimalPostModel.fromMap(data);
    } else {
      throw Exception('Falha ao criar post de animal na API');
    }
  }
}
