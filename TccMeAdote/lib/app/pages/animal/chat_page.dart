import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Título da Página'),
        ),
        body: Center(
          child: Text(
            'Tela do Chat',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
