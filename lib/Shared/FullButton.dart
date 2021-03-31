import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class FullButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  FullButton({key, this.title, this.onPressed}) : super(key: key);

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
