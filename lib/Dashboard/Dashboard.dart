import 'package:chickentender/Dashboard/Upcoming.dart';
import 'package:chickentender/Shared/Button.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PADDING),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard',
                    style: heading,
                  ),
                  DecoratedBox(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red),
                  )
                ],
              ),
            ),
            Expanded(child: Upcoming(),),
            Padding(
              padding: EdgeInsets.only(
                  left: PADDING, right: PADDING, top: 40, bottom: PADDING),
              child: Image.asset(
                'images/dashboard_illustration.png',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PADDING),
              child: Button(
                title: 'Create New Event',
                onPressed: () => debugPrint('boop'),
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
                  enabledBorder:UnderlineInputBorder(
                    borderSide: const BorderSide(color: PURPLE_DARK, width: 2),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide: const BorderSide(color: PURPLE_DARK, width: 2),
                  ),
                  focusColor: WHITE,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PADDING),
              child: Button(
                title: 'Join Event',
                onPressed: () => debugPrint('join'),
              ),
            ),
            SizedBox(height: PADDING,)
          ],
        ),
      ),
    );
  }
}
