import 'package:chickentender/Create/CreateEvent.dart';
import 'package:chickentender/Dashboard/Upcoming.dart';
import 'package:chickentender/Shared/FullButton.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  _createNewEvent() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => CreateEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PADDING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard',
                  style: heading,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: DecoratedBox(
                    child: Icon(
                      Icons.person,
                      color: PURPLE,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 211,
            child: Upcoming(),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: PADDING, right: PADDING, top: 40, bottom: PADDING),
            child: Image.asset(
              'images/dashboard_illustration.png',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PADDING),
            child: FullButton(
              title: 'Create New Event',
              onPressed: _createNewEvent,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: PADDING, right: PADDING, top: 40, bottom: PADDING),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(color: WHITE),
              decoration: InputDecoration(
                hintText: 'Event Code',
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: PURPLE_DARK, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: PURPLE_DARK, width: 2),
                ),
                focusColor: WHITE,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PADDING),
            child: FullButton(
              title: 'Join Event',
              onPressed: () => debugPrint('join'),
            ),
          ),
          SizedBox(
            height: PADDING,
          )
        ],
      ),
    );
  }
}
