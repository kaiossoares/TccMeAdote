import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/http/http_client.dart';
import '../../data/repositories/animal_post_repository.dart';
import '../../ui/widgets/adote_card.dart';
import '../../data/repositories/favorites_repository.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoritesPage> {
  late final AnimalPostRepository _animalPostRepository;
  late List<Map<String, dynamic>> _favoritePosts;
  late IHttpClient _httpClient;

  @override
  void initState() {
    super.initState();
    _httpClient = HttpClient();
    _animalPostRepository = AnimalPostRepository(client: _httpClient);
    _favoritePosts = [];
    _loadFavoritePosts();
  }

  Future<void> _loadFavoritePosts() async {
    try {
      final posts = await _animalPostRepository.fetchFavoritesAnimalPosts();
      setState(() {
        _favoritePosts = posts;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os posts favoritos: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _animalPostRepository.fetchFavoritesAnimalPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Erro ao carregar os posts favoritos: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum post favorito disponível.'));
        } else {
          return ListView(
            children: snapshot.data!.map((post) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: AdoteCard(
                  postId: post['id'],
                  animalName: post['animalName'],
                  animalType: post['animalType'],
                  breedName: post['breedName'] ?? 'Não especificada',
                  sex: post['sex'],
                  age: post['age'],
                  firstImageUrl: post['firstImageUrl'],
                  favorite: post['favorite'] ?? false,
                  favoriteRepository: FavoriteRepository(client: HttpClient()),
                  onFavoritePressed: () {
                    setState(() {
                      post['favorite'] = !(post['favorite'] ?? false);
                    });
                  },
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}

