import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/ui/widgets/adote_button.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.02),
                    _buildLogo(context),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    _buildImage(constraints),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _buildDescription(constraints),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Spacer(),
                    _buildAccessButton(context, constraints),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    _buildLoginLink(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BoxConstraints constraints) {
    return Image.asset(
      'assets/images/inicial.png',
      width: constraints.maxWidth * 0.7,
      height: constraints.maxWidth * 0.7,
    );
  }

  Widget _buildDescription(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.9,
      child: Text(
        'Compreendemos que o processo de adoção de um animal, muitas vezes não resulta como o esperado,' +
            'como um animal que não está em condições para ser adotado ou um tutor que não apresenta estrutura para tal.',
        style: TextStyle(
            fontSize: constraints.maxWidth * 0.033,
            fontFamily: 'Inter-Regular'),
      ),
    );
  }

  Widget _buildAccessButton(BuildContext context, BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: constraints.maxHeight * 0.0),
      child: AdoteButton(
        width: double.infinity,
        label: 'ACESSAR',
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/pets');
        },
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Text('Já tem uma conta?'),
      ),
    );
  }
}
