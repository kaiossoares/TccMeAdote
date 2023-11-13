class FavoriteModel {
  final String userFirebaseUid;
  final int postId;

  FavoriteModel({
    required this.userFirebaseUid,
    required this.postId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      userFirebaseUid: json['userFirebaseUid'],
      postId: json['postId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userFirebaseUid': userFirebaseUid,
    'postId': postId,
  };
}
