import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String title;
  VoidCallback onPressed;

  Button({key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed,
        child: Text(
          title,
          style: body,
        ),
      ),
    );
  }
}
