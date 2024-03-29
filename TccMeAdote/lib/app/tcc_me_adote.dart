import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tcc_me_adote/app/pages/animal/pet_list_page.dart';
import 'package:tcc_me_adote/app/pages/animal/profile_page.dart';
import 'package:tcc_me_adote/app/pages/login/register_page.dart';
import 'package:tcc_me_adote/app/pages/splash/splash_page.dart';
import 'package:tcc_me_adote/app/pages/login/login_page.dart';
import 'package:tcc_me_adote/app/pages/animal/post_page.dart';
import 'package:tcc_me_adote/app/pages/animal/favorites_page.dart';
import 'package:tcc_me_adote/app/pages/animal/chat_page.dart';
import 'package:tcc_me_adote/app/ui/widgets/adote_bottom_navigation_bar.dart';

class TccMeAdote extends StatelessWidget {
  const TccMeAdote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me Adote',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Splash(),
        '/home': (context) => AdoteBottomNavigationBar(),
        '/pets': (context) => PetListPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/post': (context) => PostPage(),
        '/favorites': (context) => FavoritesPage(),
        '/chat': (context) => ChatPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
