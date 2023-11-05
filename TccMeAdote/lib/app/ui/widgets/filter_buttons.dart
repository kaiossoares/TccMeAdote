import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterButtons extends StatelessWidget {
  final bool isDogSelected;
  final bool isCatSelected;
  final VoidCallback onDogPressed;
  final VoidCallback onCatPressed;

  FilterButtons({
    required this.isDogSelected,
    required this.isCatSelected,
    required this.onDogPressed,
    required this.onCatPressed,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: isDogSelected ? null : onDogPressed,
          icon: SvgPicture.asset(
            'assets/images/dog-face.svg',
            height: 24,
            width: 24,
          ),
          label: Text('Cachorros'),
          style: ElevatedButton.styleFrom(
            foregroundColor: isDogSelected ? Colors.white : Colors.grey[900],
            backgroundColor:
            isDogSelected ? Colors.grey[900] : Colors.white,
            fixedSize: Size(135, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.grey[900]!),
            ),
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: isCatSelected ? null : onCatPressed,
          icon: SvgPicture.asset(
            'assets/images/cat-face.svg',
            height: 24,
            width: 24,
          ),
          label: Text('Gatos'),
          style: ElevatedButton.styleFrom(
            foregroundColor: isCatSelected ? Colors.white : Colors.grey[900],
            backgroundColor:
            isCatSelected ? Colors.grey[900] : Colors.white,
            fixedSize: Size(135, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.grey[900]!),
            ),
          ),
        ),
      ],
    );
  }
}
