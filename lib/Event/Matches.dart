import 'package:chickentender/Shared/Button.dart';
import 'package:chickentender/Shared/SharedCard.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class Matches extends StatefulWidget {
  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  buildTile() {
    return SharedCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Name', style: body),
              Text('Category', style: subBody),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address 1', style: subBody),
                    Text('Address 2', style: subBody),
                    Text('Address 3', style: subBody),
                  ],
                ),
              ),
              Button(
                text: 'go here',
                color: GREEN,
                onPressed: () => debugPrint('something'),
              )
            ],
          )
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
