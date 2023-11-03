import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Título da Página'),
        ),
        body: Center(
          child: Text(
            'Tela de Perfil',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
