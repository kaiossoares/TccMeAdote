import 'package:flutter/material.dart';

class DetailsPost extends StatelessWidget {
  final String postId;

  const DetailsPost({Key? key, required this.postId}) : super(key: key);

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
      body: Center(
        child: Text('Detalhes do Post $postId'),
      ),
    );
  }
}
