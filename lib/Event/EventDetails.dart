import 'package:chickentender/Event/Matches.dart';
import 'package:chickentender/Event/Participants.dart';
import 'package:chickentender/Event/Swipe.dart';
import 'package:chickentender/Shared/Button.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  int _activeTab;

  @override
  void initState() {
    _activeTab = 0;
    super.initState();
  }

  void _change(int tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  void _back() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PURPLE,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  onPressed: _back,
                  isPrimary: false,
                  text: 'back',
                ),
                Row(
                  children: [
                    Button(
                      onPressed: () => debugPrint('something'),
                      color: RED,
                      text: 'delete',
                    ),
                    SizedBox(
                      width: PADDING,
                    ),
                    Button(
                      onPressed: () => debugPrint('something'),
                      isPrimary: false,
                      text: 'share',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('somerhing', style: body),
                Text('somerhing', style: subBody),
                Text('somerhing', style: subBody),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                GestureDetector(
                  child: Text('Swipe',
                      style: _activeTab == 0 ? body : bodyTransparent),
                  onTap: () => _change(0),
                ),
                SizedBox(
                  width: PADDING * 2,
                ),
                GestureDetector(
                  child: Text('Matches',
                      style: _activeTab == 1 ? body : bodyTransparent),
                  onTap: () => _change(1),
                ),
                SizedBox(
                  width: PADDING * 2,
                ),
                GestureDetector(
                  child: Text('Participants',
                      style: _activeTab == 2 ? body : bodyTransparent),
                  onTap: () => _change(2),
                ),
              ],
            ),
            SizedBox(
              height: PADDING,
            ),
            if (_activeTab == 0) Swipe(),
            if (_activeTab == 1) Matches(),
            if (_activeTab == 2) Participants(),
          ],
        ),
      )),
    );
  }
}
