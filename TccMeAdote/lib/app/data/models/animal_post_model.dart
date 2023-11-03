class AnimalPostModel {
  final String animalName;
  final int animalTypeId;
  final int breedId;
  final String sex;
  final String age;
  final String description;
  final String userFirebaseUid;
  final List<String> photoUrls;

  AnimalPostModel({
    required this.animalName,
    required this.animalTypeId,
    required this.breedId,
    required this.sex,
    required this.age,
    required this.description,
    required this.userFirebaseUid,
    required this.photoUrls
  });

  factory AnimalPostModel.fromMap(Map<String, dynamic> map) {
    return AnimalPostModel(
      animalName: map['animalName'],
      animalTypeId: map['animalTypeId'],
      breedId: map['breedId'],
      sex: map['sex'],
      age: map['age'],
      description: map['description'],
      userFirebaseUid: map['userFirebaseUid'],
      photoUrls: List<String>.from(map['photoUrls'])
    );
  }
}
