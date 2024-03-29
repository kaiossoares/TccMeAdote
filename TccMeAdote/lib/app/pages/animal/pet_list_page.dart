import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/http/http_client.dart';
import '../../data/repositories/animal_post_repository.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../ui/widgets/adote_card.dart';
import 'details_post.dart';

class PetListPage extends StatefulWidget {
  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  late final AnimalPostRepository _animalPostRepository;
  late List<Map<String, dynamic>> _animalPosts;
  late IHttpClient _httpClient;
  int? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _httpClient = HttpClient();
    _animalPostRepository = AnimalPostRepository(client: _httpClient);
    _animalPosts = [];
    _loadAnimalPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAnimalPosts();
  }

  Future<void> _loadAnimalPosts() async {
    try {
      final posts =
          await _animalPostRepository.fetchAnimalPosts(_selectedCategory ?? 0);
      setState(() {
        _animalPosts = posts;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os posts: $e');
      }
    }
  }

  void _onCategoryButtonPressed(int animalType) {
    setState(() {
      _selectedCategory = _selectedCategory == animalType ? null : animalType;
    });
    _loadAnimalPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildCategoryButton(
                        'Cachorros', 'assets/images/dog-face.svg', 1),
                    SizedBox(width: 16),
                    _buildCategoryButton(
                        'Gatos', 'assets/images/cat-face.svg', 2),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      String category, String iconPath, int animalType) {
    bool isSelected = _selectedCategory == animalType;

    return ElevatedButton.icon(
      onPressed: () => _onCategoryButtonPressed(animalType),
      icon: SvgPicture.asset(
        iconPath,
        height: 24,
        width: 24,
      ),
      label: Text(category),
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.grey[900],
        backgroundColor: isSelected ? Colors.grey[900] : Colors.white,
        fixedSize: Size(135, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.grey[900]!),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _animalPostRepository.fetchAnimalPosts(_selectedCategory ?? 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Erro ao carregar os posts: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum post de animal disponível.'));
        } else {
          return ListView(
            children: snapshot.data!.map((post) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPost(postId: post['id'].toString()),
                        ),
                      );
                    },
                    child: AdoteCard(
                      postId: post['id'],
                      animalName: post['animalName'],
                      animalType: post['animalType'],
                      breedName: post['breedName'] ?? 'Não especificada',
                      sex: post['sex'],
                      age: post['age'],
                      firstImageUrl: post['firstImageUrl'],
                      favorite: post['favorite'] ?? false,
                      favoriteRepository:
                          FavoriteRepository(client: HttpClient()),
                      onFavoritePressed: () {
                        setState(() {
                          post['favorite'] = !(post['favorite'] ?? false);
                        });
                      },
                    ),
                  ));
            }).toList(),
          );
        }
      },
    );
  }
}
