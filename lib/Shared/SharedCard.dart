import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class SharedCard extends StatelessWidget {
  final Widget child;
  final bool hasPadding;

  SharedCard({key, this.child, this.hasPadding = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: PURPLE_DARK,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Color(0x40333333), blurRadius: 4, offset: Offset(0, 4.0)),
          BoxShadow(
              color: Color(0x40333333), blurRadius: 6, offset: Offset(0, 3.0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(hasPadding ? PADDING : 0),
        child: child,
      ),
    );
  }
}
