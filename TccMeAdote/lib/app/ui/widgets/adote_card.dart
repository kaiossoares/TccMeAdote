import 'package:flutter/material.dart';

class AdoteCard extends StatelessWidget {
  final String animalName;
  final String animalType;
  final String breedName;
  final String sex;
  final String age;
  final String? firstImageUrl;

  AdoteCard({
    required this.animalName,
    required this.animalType,
    required this.breedName,
    required this.sex,
    required this.age,
    required this.firstImageUrl,
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
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
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
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          animalName ?? 'Nome não disponível',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${breedName ?? 'Não especificada'}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$age',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$sex',
                          style: TextStyle(fontSize: 16.0),
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
              icon: const Icon(Icons.favorite),
              color: Colors.blue,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
