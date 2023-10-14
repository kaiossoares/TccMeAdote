class BreedsModel {
  final String breedName;

  BreedsModel({required this.breedName});

  factory BreedsModel.fromMap(Map<String, dynamic> map){
    return BreedsModel(breedName: map['breedName']);
  }
}
