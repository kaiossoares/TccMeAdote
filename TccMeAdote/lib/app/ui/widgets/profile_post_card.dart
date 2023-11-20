import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/animal/profile_page.dart';

import '../../data/repositories/animal_post_repository.dart';

const kDefaultPadding = 14.0;
const kPrimaryColor = Colors.blue;

class ProfilePostCard extends StatelessWidget {
  ProfilePage profilePage = ProfilePage();

  final int postId;
  final String animalName;
  final String imageUrl;
  final AnimalPostRepository animalPostRepository;
  final VoidCallback press;
  final BuildContext context;

  ProfilePostCard({
    required this.postId,
    required this.animalName,
    required this.imageUrl,
    required this.animalPostRepository,
    required this.press,
    required this.context,
  });

  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove_circle_sharp,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      onPressed: () async {
                        deletePost(postId, context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    animalName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deletePost(int postId, BuildContext context) async {
    void showProgressIndicator() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text("Excluindo post..."),
            ],
          ),
        ),
      );
    }

    void hideProgressIndicator() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }

    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmação"),
          content: const Text("Tem certeza que deseja excluir o post?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        showProgressIndicator();

        await Future.delayed(Duration(seconds: 1));

        await animalPostRepository.deletePost(postId);

        press();
      } catch (error) {
        print("Erro ao excluir o post: $error");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erro ao excluir o post."),
          ),
        );
      } finally {
        hideProgressIndicator();
        profilePage.reloadPosts();
      }
    }
  }
}
