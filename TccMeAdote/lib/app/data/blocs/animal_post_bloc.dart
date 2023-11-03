import 'package:flutter/foundation.dart';

import '../models/animal_post_model.dart';
import '../repositories/animal_post_repository.dart';

class AnimalPostBloc {
  final AnimalPostRepository _animalPostRepository;

  AnimalPostBloc(this._animalPostRepository);

  Future<void> createAnimalPost({
    required String animalName,
    required int animalTypeId,
    required int breedId,
    required String sex,
    required String age,
    required String description,
    String? userFirebaseUid,
    required List<String> photoUrls,
  }) async {
    try {
      String finalUserFirebaseUid = userFirebaseUid ?? '';
      AnimalPostModel animalPost = AnimalPostModel(
        animalName: animalName,
        animalTypeId: animalTypeId,
        breedId: breedId,
        sex: sex,
        age: age,
        description: description,
        userFirebaseUid: finalUserFirebaseUid,
        photoUrls: photoUrls
      );

      await _animalPostRepository.createAnimalPost(animalPost, photoUrls);
      if (kDebugMode) {
        print('Post de animal criado com sucesso.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao criar post de animal: $e');
      }
    }
  }
}
