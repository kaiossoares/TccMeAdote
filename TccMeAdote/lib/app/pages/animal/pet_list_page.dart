import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/animal/profile_page.dart';
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
    FavoritesPage(),
    PostPage(),
    ChatPage(),
    ProfilePage()
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
                              20.0),
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
                              20.0),
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
