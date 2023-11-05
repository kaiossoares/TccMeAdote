import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc_me_adote/app/pages/animal/profile_page.dart';
import '../../data/http/http_client.dart';
import '../../data/repositories/animal_post_repository.dart';
import '../../ui/widgets/adote_bottomnavigationbar.dart';
import 'package:tcc_me_adote/app/pages/animal/post_page.dart';
import 'package:tcc_me_adote/app/pages/animal/favorites_page.dart';
import 'package:tcc_me_adote/app/pages/animal/chat_page.dart';
import '../../ui/widgets/adote_card.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  late final AnimalPostRepository _animalPostRepository;
  late List<Map<String, dynamic>> _animalPosts;
  late List<Widget> _pages;
  late IHttpClient _httpClient;
  int _selectedIndex = 0;

  bool isDogSelected = false;
  bool isCatSelected = false;

  void _onDogButtonPressed() {
    setState(() {
      isDogSelected = !isDogSelected;
      if (isDogSelected) {
        isCatSelected = false;
      }
    });
  }

  void _onCatButtonPressed() {
    print(isDogSelected);
    print(isCatSelected);
    setState(() {
      isCatSelected = !isCatSelected;
      if (isCatSelected) {
        isDogSelected = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _httpClient = HttpClient();
    _animalPostRepository = AnimalPostRepository(client: _httpClient);
    _animalPosts = [];
    _initializePages();
    _loadAnimalPosts();
    _animalPostRepository.fetchAnimalPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAnimalPosts();
  }

  void _initializePages() {
    _pages = [
      _buildPetListPageContent(),
      FavoritesPage(),
      PostPage(),
      ChatPage(),
      ProfilePage()
    ];
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

  Widget _buildPetListPageContent() {
    return Column(
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
                  ElevatedButton.icon(
                    onPressed: _onDogButtonPressed,
                    icon: SvgPicture.asset(
                      'assets/images/dog-face.svg',
                      height: 24,
                      width: 24,
                    ),
                    label: Text('Cachorros'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: isDogSelected ? Colors.white : Colors.grey[900],
                      backgroundColor: isDogSelected ? Colors.grey[900] : Colors.white,
                      fixedSize: Size(135, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey[900]!),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _onCatButtonPressed,
                    icon: SvgPicture.asset(
                      'assets/images/cat-face.svg',
                      height: 24,
                      width: 24,
                    ),
                    label: Text('Gatos'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: isCatSelected ? Colors.white : Colors.grey[900],
                      backgroundColor: isCatSelected ? Colors.grey[900] : Colors.white,
                      fixedSize: Size(135, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey[900]!),
                      ),
                    ),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color minhaCor = Color(0xFFF9F9F9);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: minhaCor,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          items: [
            AdoteBottomNavigationBarItem(
              iconData: Icons.search,
              label: 'Procurar',
            ),
            AdoteBottomNavigationBarItem(
              iconData: Icons.favorite,
              label: 'Favoritos',
            ),
            AdoteBottomNavigationBarItem(
              iconData: Icons.add_circle_outline,
              label: 'Post',
            ),
            AdoteBottomNavigationBarItem(
              iconData: Icons.chat_outlined,
              label: 'Chat',
            ),
            AdoteBottomNavigationBarItem(
              iconData: Icons.account_circle_rounded,
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
