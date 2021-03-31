import 'package:chickentender/Shared/Button.dart';
import 'package:chickentender/Shared/SharedCard.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class Participants extends StatefulWidget {
  @override
  _ParticipantsState createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  buildTile() {
    return SharedCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Name Name',
            style: body,
          ),
          Button(
            text: 'kick',
            color: RED,
            onPressed: () => debugPrint('something'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildTile()],
    );
  }
}
