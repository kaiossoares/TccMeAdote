import 'package:flutter/material.dart';

import '../../pages/animal/chat_page.dart';
import '../../pages/animal/favorites_page.dart';
import '../../pages/animal/pet_list_page.dart';
import '../../pages/animal/post_page.dart';
import '../../pages/animal/profile_page.dart';

class AdoteBottomNavigationBar extends StatefulWidget {
  @override
  _AdoteBottomNavigationBarState createState() => _AdoteBottomNavigationBarState();

  static void redirectToSearch(BuildContext context) {
    final state = of(context);
    state?._redirectToSearch();
  }

  static _AdoteBottomNavigationBarState? of(BuildContext context) {
    return context.findAncestorStateOfType<_AdoteBottomNavigationBarState>();
  }
}

class _AdoteBottomNavigationBarState extends State<AdoteBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PetListPage(),
    FavoritesPage(),
    PostPage(),
    ChatPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _redirectToSearch() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Procurar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
