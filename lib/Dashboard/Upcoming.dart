import 'package:chickentender/Shared/EventCard.dart';
import 'package:chickentender/Shared/SharedCard.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class Upcoming extends StatefulWidget {
  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: PADDING, right: PADDING, top: 40, bottom: PADDING),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upcoming',
                style: body,
              ),
              Text(
                'view past events',
                style: subBody,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: PADDING,
                height: PADDING,
              ),
              EventCard(),
              SizedBox(
                width: PADDING,
                height: PADDING,
              ),
              EventCard(),
              SizedBox(
                width: PADDING,
                height: PADDING,
              ),
              EventCard(),
              SizedBox(
                width: PADDING,
                height: PADDING,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
