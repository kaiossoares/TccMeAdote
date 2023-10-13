  import 'package:tcc_me_adote/app/data/models/animal_type_model.dart';
import '../../data/repositories/animal_type_repository.dart';
import 'package:flutter/material.dart';

class AnimalTypeStore {
  final IAnimalTypeRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<AnimalTypeModel>> state = ValueNotifier<List<AnimalTypeModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  AnimalTypeStore({required this.repository});

  Future<void> loadAnimalTypes() async {
    isLoading.value = true;

    try {
      final result = await repository.getAnimalTypes();
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

}