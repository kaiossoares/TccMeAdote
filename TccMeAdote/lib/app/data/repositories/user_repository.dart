import 'dart:convert';

import '../http/http_client.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> registerUser(UserModel user);
}

class UserRepository implements IUserRepository {
  final IHttpClient client;

  UserRepository({required this.client});

  @override
  Future<UserModel> registerUser(UserModel user) async {

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'userFirebaseUid': user.userFirebaseUid,
    };

    final response = await client.post(
      url: 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/users/register',
      headers: headers,
      body: requestBody,
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return UserModel.fromMap(data);
    } else {
      throw Exception('Falha ao registrar usuário na API');
    }
  }
}