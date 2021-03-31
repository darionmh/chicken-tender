import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final Color color;
  final VoidCallback onPressed;

  Button(
      {key,
      this.text,
      this.isPrimary = true,
      this.color = WHITE,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return color;
          }),
          side: MaterialStateProperty.resolveWith<BorderSide>((states) {
            return BorderSide(width: 2, color: color);
          }),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: WHITE),
        ),
      );
    } else {
      return OutlinedButton(
        child: new Text(
          text,
          style: TextStyle(color: WHITE),
        ),
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>((states) {
            return BorderSide(width: 2, color: WHITE);
          }),
        ),
      );
    }
  }
}
