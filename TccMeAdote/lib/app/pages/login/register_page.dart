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
  final TextEditingController confirmarSenhaController = TextEditingController();
  bool loading = false;
  String? imagePath;
  File? imageFile;

  void registrar() async {
    setState(() => loading = true);

    try {
      if (senhaController.text != confirmarSenhaController.text) {
        setState(() => loading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("As senhas não coincidem."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
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
        PasswordFormField(context: context, controller: senhaController, label: 'Senha'),
        const SizedBox(
          height: 30,
        ),
        PasswordFormField(context: context, controller: confirmarSenhaController, label: 'Confirma Senha'),
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

class PasswordFormField extends StatefulWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String label;

  const PasswordFormField({Key? key, required this.context, required this.controller, required this.label})
      : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
    );
  }
}
