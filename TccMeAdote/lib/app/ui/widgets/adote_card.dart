import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/favorites_repository.dart';

class AdoteCard extends StatelessWidget {
  final int postId;
  final String animalName;
  final String animalType;
  final String breedName;
  final String sex;
  final String age;
  final String? firstImageUrl;
  final bool favorite;
  final FavoriteRepository favoriteRepository;
  final VoidCallback? onFavoritePressed;

  AdoteCard({
    required this.postId,
    required this.animalName,
    required this.animalType,
    required this.breedName,
    required this.sex,
    required this.age,
    required this.firstImageUrl,
    required this.favorite,
    required this.favoriteRepository,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child:
                        (firstImageUrl != null && firstImageUrl!.isNotEmpty)
                            ? Image.network(
                          firstImageUrl!,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      (loadingProgress
                                          .expectedTotalBytes ??
                                          1)
                                      : null,
                                ),
                              );
                            }
                          },
                        )
                            : Image.asset(
                          'assets/images/default.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          animalName ?? 'Nome não disponível',
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          breedName ?? 'Não especificada',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          age,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          sex,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: IconButton(
              icon: favorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border_outlined),
              color: Colors.blue,
              onPressed: () async {
                try {
                  if (favorite) {
                    await favoriteRepository.removeFavorite(postId);
                  } else {
                    await favoriteRepository.addFavorite(postId);
                  }
                  if (onFavoritePressed != null) {
                    onFavoritePressed!();
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Erro ao manipular favoritos: $e');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
