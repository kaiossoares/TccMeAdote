import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_me_adote/app/ui/styles/text_styles.dart';
import 'package:tcc_me_adote/app/ui/widgets/adote_appbar.dart';
import 'package:tcc_me_adote/app/ui/widgets/adote_button.dart';
import 'package:tcc_me_adote/app/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool loading = false;

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(nameController.text,
          emailController.text, senhaController.text, context);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AdoteAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
              ),
            ),
          ),
        ));
  }
}
