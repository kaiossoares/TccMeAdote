class AnimalTypeModel {
  final String animalTypes;

  AnimalTypeModel({required this.animalTypes});

  factory AnimalTypeModel.fromMap(Map<String, dynamic> map){
    return AnimalTypeModel(animalTypes: map['animalType']);
  }
}