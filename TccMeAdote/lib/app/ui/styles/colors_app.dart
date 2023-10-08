import 'package:flutter/cupertino.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get i {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => Color.fromRGBO(0, 102, 255, 0);
  Color get secondary => Color.fromRGBO(72, 201, 255, 0);
}

extension ColorsAppExtesions on BuildContext{
  ColorsApp get colors => ColorsApp.i;
}