import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class SharedCard extends StatelessWidget {

  Widget child;

  SharedCard({key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: PURPLE_DARK,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Color(0x40333333), blurRadius: 4, offset: Offset(0, 4.0)),
            BoxShadow(color: Color(0x40333333), blurRadius: 6, offset: Offset(0, 3.0)),
          ]
      ),
      child: Padding(
        padding: EdgeInsets.all(PADDING),
        child: child,
      ),
    );
  }
}
