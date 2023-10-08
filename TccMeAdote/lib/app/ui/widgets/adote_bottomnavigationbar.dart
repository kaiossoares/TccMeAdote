import 'package:flutter/material.dart';

class AdoteBottomNavigationBarItem extends BottomNavigationBarItem {
  final bool isSelected;
  AdoteBottomNavigationBarItem({
    required IconData iconData,
    required String label,
    this.isSelected = false,
  }) : super(
    icon: Icon(
      iconData,
    ),
    label: label,
  );
}
