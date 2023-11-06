import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/http/http_client.dart';
import '../../data/repositories/animal_post_repository.dart';
import '../../ui/widgets/adote_card.dart';

class PetListPage extends StatefulWidget {
  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  late final AnimalPostRepository _animalPostRepository;
  late List<Map<String, dynamic>> _animalPosts;
  late IHttpClient _httpClient;

  @override
  void initState() {
    super.initState();
    _httpClient = HttpClient();
    _animalPostRepository = AnimalPostRepository(client: _httpClient);
    _animalPosts = [];
    _loadAnimalPosts();
    _animalPostRepository.fetchAnimalPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAnimalPosts();
  }

  Future<void> _loadAnimalPosts() async {
    try {
      final posts = await _animalPostRepository.fetchAnimalPosts();
      setState(() {
        _animalPosts = posts;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os posts: $e');
      }
    }
  }

  String _selectedCategory = '';

  void _onCategoryButtonPressed(String category) {
    setState(() {
      if (_selectedCategory == category) {
        _selectedCategory = '';
      } else {
        _selectedCategory = category;
      }
    });
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
                      'Cachorros',
                      'assets/images/dog-face.svg',
                    ),
                    SizedBox(width: 16),
                    _buildCategoryButton(
                      'Gatos',
                      'assets/images/cat-face.svg',
                    ),
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

  Widget _buildCategoryButton(String category, String iconPath) {
    bool isSelected = _selectedCategory == category;

    return ElevatedButton.icon(
      onPressed: () => _onCategoryButtonPressed(category),
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
      future: _animalPostRepository.fetchAnimalPosts(),
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
                child: AdoteCard(
                  animalName: post['animalName'],
                  animalType: post['animalType'],
                  breedName: post['breedName'] ?? 'Não especificada',
                  sex: post['sex'],
                  age: post['age'],
                  firstImageUrl:
                  post['firstImageUrl'],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}