import 'package:chickentender/Event/EventDetails.dart';
import 'package:chickentender/Shared/SharedCard.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => EventDetails()),
      ),
      child: SharedCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Event Name', style: cardBody),
            Text('Place Name', style: cardSubtext),
            Text('3/16/21 - 10:30 AM', style: cardSubtext),
            Text('Columbia, MO', style: cardSubtext),
          ],
        ),
      ),
    );
  }
}
