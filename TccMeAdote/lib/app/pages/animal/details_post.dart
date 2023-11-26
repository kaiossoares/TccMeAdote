import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/data/repositories/animal_post_repository.dart';

import '../../data/http/http_client.dart';
import 'chat_page_conversation.dart';

class DetailsPost extends StatefulWidget {
  final String postId;

  const DetailsPost({Key? key, required this.postId}) : super(key: key);

  @override
  _DetailsPostState createState() => _DetailsPostState();
}

class _DetailsPostState extends State<DetailsPost> {
  late final AnimalPostRepository _animalPostRepository;
  late Future<void> postFuture;
  late Future<void> postUserFuture;
  late List<Map<String, dynamic>> _post;
  late List<Map<String, dynamic>> _postUser;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animalPostRepository = AnimalPostRepository(client: HttpClient());
    _post = [];
    _postUser = [];
    postFuture = _loadPost();
    postUserFuture = _loadUserByPostId();
  }

  Future<void> _loadPost() async {
    try {
      final posts = await _animalPostRepository.fetchPostById(int.parse(widget.postId));
      setState(() {
        _post = posts;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar o post: $e');
      }
    }
  }

  Future<void> _loadUserByPostId() async {
    try {
      final postUser = await _animalPostRepository.fetchPostByUserId(int.parse(widget.postId));

      setState(() {
        _postUser = [postUser];
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar o usuário do post: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<void>(
        future: postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os detalhes do post.'));
          } else {
            if (_post.isNotEmpty && _postUser.isNotEmpty) {
              final post = _post[0];
              final user = _postUser[0];

              if (post != null && user != null) {
                final List<String> imageUrls = List<String>.from(post['imageUrls']);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      buildImageCarousel(imageUrls),
                      const SizedBox(height: 20),
                      TextSectionWidget(post: post),
                      const SizedBox(height: 20),
                      UserDetails(
                        userName: user['name'] ?? 'Nome não disponível',
                        profilePictureUrl: user['profilePictureUrl'] ?? 'URL não disponível',
                      ),
                      TextSectionWidgetDescription(post: post, showLabel: false),
                      const SizedBox(width: 8),
                      buildChatButton(),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Post não encontrado.'));
              }
            } else {
              return const Center(child: Text(''));
            }
          }
        },
      ),
    );
  }

  Widget buildImageCarousel(List<String> imageUrls) {
    return Column(
      children: [
        Stack(
          children: [
            buildCarouselSlider(imageUrls),
            buildPageIndicator(imageUrls),
          ],
        ),
      ],
    );
  }

  Widget buildCarouselSlider(List<String> imageUrls) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          print(currentIndex);
        }
      },
      child: CarouselSlider(
        items: imageUrls.map((url) {
          return Container(
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        }).toList(),
        carouselController: carouselController,
        options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          autoPlay: false,
          aspectRatio: 1.3,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget buildPageIndicator(List<String> imageUrls) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageUrls.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => carouselController.animateToPage(entry.key),
            child: Container(
              width: currentIndex == entry.key ? 17 : 7,
              height: 7.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 3.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentIndex == entry.key ? Colors.blue : Colors.white,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget TextSectionWidget({required Map<String, dynamic> post}) {
    return Column(
      children: [
        textInfo('', post['animalName'], isLabelBold: true, nomeFontSize: 26),
        textInfo('Tipo', post['animalType']),
        textInfo('Raça', post['breedName']),
        textInfo('Sexo', post['sex']),
        textInfo('Idade', post['age']),
      ],
    );
  }

  Widget textInfo(String label, String value, {bool isLabelBold = false, double fontSize = 16, double nomeFontSize = 22, double fontStrength = 1.2}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: label.isEmpty ? 23 : 4, horizontal: label.isEmpty ? 18 : 18),
      child: Row(
        children: [
          if (label.isNotEmpty) ...[
            Text(
              '$label: ',
              style: TextStyle(fontWeight: isLabelBold ? FontWeight.bold : FontWeight.w600, fontSize: fontSize * fontStrength),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: label.isEmpty ? FontWeight.bold : FontWeight.w400,
                fontSize: label.isEmpty ? nomeFontSize : fontSize * fontStrength,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TextSectionWidgetDescription({required Map<String, dynamic> post, bool showLabel = false}) {
    final description = post['description'] ?? '';
    final label = showLabel ? 'Descrição' : '';

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: label.isEmpty ? 23 : 4, horizontal: label.isEmpty ? 18 : 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label.isNotEmpty) ...[
                Text(
                  label,
                  style: const TextStyle(fontSize: 16 * 1.2, fontWeight: FontWeight.normal),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16 * 1.2,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget UserDetails({required String userName, required String profilePictureUrl}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (profilePictureUrl.isNotEmpty)
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(profilePictureUrl),
            ),
          const SizedBox(width: 10),
          Text(
            userName,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget buildChatButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              int postId = int.tryParse(widget.postId) ?? 0;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16.0),
                        Text("Carregando..."),
                      ],
                    ),
                  );
                },
              );

              try {
                final userData = await _animalPostRepository.fetchReceiverUserData(postId.toString());
                Navigator.pop(context); // Fecha o AlertDialog após a conclusão da operação

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPageConversation(
                      receiverUserEmail: userData['email'],
                      receiverUserId: userData['userFirebaseUid'],
                    ),
                  ),
                );
              } catch (error) {
                Navigator.pop(context); // Fecha o AlertDialog em caso de erro
                print("Erro: $error");
              }
            },
            icon: const Icon(Icons.chat),
            label: const Text('Chat'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              minimumSize: const Size(double.infinity, 48.0),
            ),
          ),
        ],
      ),
    );
  }
}

