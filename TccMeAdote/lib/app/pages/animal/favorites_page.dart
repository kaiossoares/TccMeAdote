import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Título da Página'),
        ),
        body: Center(
          child: Text(
            'Tela de Favoritos',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
