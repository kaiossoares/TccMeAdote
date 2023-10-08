import 'package:flutter/material.dart';
import '../../ui/widgets/adote_bottomnavigationbar.dart';
import 'package:tcc_me_adote/app/pages/animal/post_page.dart';
import 'package:tcc_me_adote/app/pages/animal/favorites_page.dart';
import 'package:tcc_me_adote/app/pages/animal/chat_page.dart';
import '../../ui/styles/text_styles.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    _buildPetListPageContent(),
    PostPage(),
    FavoritesPage(),
    ChatPage(),
  ];

  static Widget _buildPetListPageContent() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.02),
                _buildProfile(context),
                Text('Categoria Pets',
                    style: context.textStyles.textTitleMedium),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Cachorro'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Valor de borderRadius define a curvatura das bordas
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Gato'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Valor de borderRadius define a curvatura das bordas
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildProfile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Image.asset(
              'assets/images/perfil.png',
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ),
      ],
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
              iconData: Icons.add_circle_outline,
              label: 'Post',
            ),
            AdoteBottomNavigationBarItem(
              iconData: Icons.favorite,
              label: 'Favoritos',
            ),
            AdoteBottomNavigationBarItem(
              iconData: Icons.chat_outlined,
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
