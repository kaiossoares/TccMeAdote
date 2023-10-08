import 'package:flutter/material.dart';

class AdoteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;

  const AdoteButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  40.0),
            ),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
