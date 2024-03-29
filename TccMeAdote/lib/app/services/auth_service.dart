import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/http/http_client.dart';
import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';

class AuthException implements Exception {
  String message;

  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String? userFirebaseUid;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = user;
      if (user != null) {
        userFirebaseUid = user.uid;
        _getUserUid();
      } else {
        userFirebaseUid = null;
      }
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  Future<void> _getUserUid() async {
    userFirebaseUid = usuario?.uid;
    notifyListeners();
  }

  Future<String?> getUserFirebaseUid() async {
    await _getUserUid();
    return userFirebaseUid;
  }

  bool isEmailValid(String email) {
    String emailRegex =
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  Future<void> registrar(String name, String email, String imageUrl, String senha, BuildContext context) async {
    if (!isEmailValid(email)) {
      throw AuthException('Endereço de e-mail inválido.');
    }
    try {
      final IHttpClient _httpClient = HttpClient();

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      String userFirebaseUid = userCredential.user?.uid ?? '';

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      var user = UserModel(
        name: name,
        email: email,
        imageUrl: imageUrl,
        password: senha,
        userFirebaseUid: userFirebaseUid,
      );

      var userRepository = UserRepository(client: _httpClient);
      await userRepository.registerUser(user);

      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está cadastrado!');
      } else {
        throw AuthException('Erro ao fazer cadastro, tente novamente!');
      }
    }
  }

  login(String email, String senha, BuildContext context) async {
    if (!isEmailValid(email)) {
      throw AuthException('Endereço de e-mail inválido.');
    }
    try {

      UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(email: email, password: senha);

      _getUser();

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Dados não encontrados, cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta, tente novamente!');
      } else {
        throw AuthException(
            'Erro ao fazer login. E-mail ou senha incorretos, tente novamente!');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
