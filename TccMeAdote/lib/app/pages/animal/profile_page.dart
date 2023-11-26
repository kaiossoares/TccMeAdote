import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc_me_adote/app/data/repositories/animal_post_repository.dart';
import 'package:tcc_me_adote/app/pages/animal/settings_page.dart';

import '../../data/http/http_client.dart';
import '../../services/auth_service.dart';
import '../../ui/widgets/profile_post_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();

  void reloadPosts() {
    _profilePageState?.reloadPosts();
  }
}

_ProfilePageState? _profilePageState;

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> posts = [];

  final double coverHeight = 135;
  final double profileHeight = 144;

  final IHttpClient httpClient = HttpClient();

  String nome = "";
  String email = "";
  String fotoPerfilUrl = "";
  bool isLoading = true;
  bool isLoadingPosts = true;

  @override
  void initState() {
    super.initState();
    carregarDadosDoEndpoint();
    carregarPostsDoEndpoint();
    _profilePageState = this;
  }

  Future<void> carregarDadosDoEndpoint() async {
    try {
      String? userFirebaseUid = await AuthService().getUserFirebaseUid();
      final endpointUrl = 'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/users/$userFirebaseUid';
      final response = await httpClient.get(url: endpointUrl);

      if (mounted) {
        if (response.statusCode == 200) {
          Map<String, dynamic> dadosUsuario = jsonDecode(response.body);
          setState(() {
            nome = dadosUsuario['name'];
            email = dadosUsuario['email'];
            fotoPerfilUrl = dadosUsuario['profilePictureUrl'];
            isLoading = false;
          });
        } else {
          handleError('Falha ao carregar os dados do usuário.');
        }
      }
    } catch (e) {
      handleError('Erro na requisição: $e');
    }
  }

  Future<void> carregarPostsDoEndpoint() async {
    try {
      String? userFirebaseUid = await AuthService().getUserFirebaseUid();
      final postsEndpointUrl =
          'https://tcc-meadote-api-062678c8588e.herokuapp.com/api/posts/list/uid/$userFirebaseUid';
      final response = await httpClient.get(url: postsEndpointUrl);

      if (mounted) {
        if (response.statusCode == 200) {
          List<dynamic> postsData = jsonDecode(response.body);
          List<Map<String, dynamic>> posts = postsData.cast<Map<String, dynamic>>();

          setState(() {
            this.posts = posts;
            isLoadingPosts = false;
          });
        } else {
          handleError('Falha ao carregar os posts.');
        }
      }
    } catch (e) {
      handleError('Erro na requisição de posts: $e');
    }
  }

  void reloadPosts() {
    carregarPostsDoEndpoint();
  }

  void handleError(String message) {
    if (mounted) {
      if (kDebugMode) {
        print(message);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImageWithLoading(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: SvgPicture.asset('assets/images/rectangle.svg', width: double.infinity, height: coverHeight, fit: BoxFit.cover),
  );

  Widget buildProfileImageWithLoading() => Stack(
    alignment: Alignment.center,
    children: [
      buildProfileImage(),
      isLoading
          ? const CircularProgressIndicator()
          : Container(),
    ],
  );

  Widget buildProfileImage() => Center(
    child: Stack(
      children: [
        CircleAvatar(
          radius: profileHeight / 2,
          backgroundColor: Colors.grey.shade800,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                fotoPerfilUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.white,
                      size: profileHeight,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ),
  );

  Widget buildContent() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          nome,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          email,
          style: const TextStyle(fontSize: 20, color: Colors.black54),
        ),
        const SizedBox(height: 20),
        if (posts.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Meus posts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (isLoadingPosts)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  ),
                ),
              ...posts.map((post) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfilePostCard(
                    postId: post['id'],
                    animalName: post['animalName'],
                    imageUrl: post['firstImageUrl'],
                    animalPostRepository: AnimalPostRepository(client: HttpClient()),
                    press: () {
                    },
                    context: context,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
