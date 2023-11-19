class UserModel {
  final String name;
  final String email;
  final String imageUrl;
  final String password;
  final String userFirebaseUid;

  UserModel({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.password,
    required this.userFirebaseUid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      imageUrl: map['profilePictureUrl'],
      password: map['password'],
      userFirebaseUid: map['userFirebaseUid'],
    );
  }
}