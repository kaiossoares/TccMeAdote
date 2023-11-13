import '../../services/auth_service.dart';
import '../http/http_client.dart';

class FavoriteRepository {
  final IHttpClient client;

  FavoriteRepository({required this.client});

  Future<void> addFavorite(int postId) async {
    String? userFirebaseUid = await AuthService().getUserFirebaseUid();

    const url = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/favorites/add';
    final headers = {'Content-Type': 'application/json'};

    final body = {'userFirebaseUid': userFirebaseUid, 'postId': postId};

    final response = await client.post(
      url: url,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar aos favoritos');
    }
  }

  Future<void> removeFavorite(int postId) async {
    String? userFirebaseUid = await AuthService().getUserFirebaseUid();
    print("dados:");
    print(postId);
    print(userFirebaseUid);

    const url = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/favorites/remove';
    final headers = {'Content-Type': 'application/json'};

    final body = {'userFirebaseUid': userFirebaseUid, 'postId': postId};

    final response = await client.delete(
      url: url,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao remover dos favoritos');
    }
  }
}
