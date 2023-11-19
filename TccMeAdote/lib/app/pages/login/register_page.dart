import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tcc_me_adote/app/ui/styles/text_styles.dart';
import 'package:tcc_me_adote/app/ui/widgets/adote_appbar.dart';
import 'package:tcc_me_adote/app/ui/widgets/adote_button.dart';
import 'package:tcc_me_adote/app/services/auth_service.dart';
import 'dart:io';

import '../../services/firebase_storage_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool loading = false;
  String? imagePath;
  File? imageFile;

  void registrar() async {
    setState(() => loading = true);
    try {
      String imageUrl = '';

      if (imageFile != null) {
        imageUrl = await _firebaseStorageService.uploadProfileImage(imageFile!, 'profileImages');
      }

      await context.read<AuthService>().registrar(
        nameController.text,
        emailController.text,
        imageUrl,
        senhaController.text,
        context,
      );
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imagePath = pickedFile.path;
      });
    }
  }

  Widget buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.white),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: imagePath != null
                  ? Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                width: 130,
                height: 130,
              )
                  : SvgPicture.asset(
                'assets/images/profile-circle.svg',
                fit: BoxFit.cover,
                width: 130,
                height: 130,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
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
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cadastro',
          style: context.textStyles.textTitle,
        ),
        Text(
          'Preencha os campos abaixo para criar o seu perfil.',
          style: context.textStyles.textMedium.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 30),
        buildProfileImage(),
        const SizedBox(height: 15),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'E-mail'),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: senhaController,
          decoration: const InputDecoration(labelText: 'Senha'),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          decoration:
          const InputDecoration(labelText: 'Confirma Senha'),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: loading
              ? CircularProgressIndicator()
              : AdoteButton(
            width: double.infinity,
            label: 'Cadastrar',
            onPressed: () {
              registrar();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdoteAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: buildForm(),
          ),
        ),
      ),
    );
  }
}
