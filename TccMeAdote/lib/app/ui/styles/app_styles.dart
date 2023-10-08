import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/ui/styles/colors_app.dart';
import 'package:tcc_me_adote/app/ui/styles/text_styles.dart';

class AppStyles {
  static AppStyles? _instance;

  AppStyles._();

  static AppStyles get i {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      backgroundColor: ColorsApp.i.primary,
      textStyle: TextStyles.i.textBold);
}

extension AppStylesExtensions on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
