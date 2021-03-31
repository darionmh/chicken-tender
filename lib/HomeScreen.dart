import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _createUpcomingBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(PADDING),
          child: Text(
            'Upcoming Events',
            style: heading,
          ),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _createInviteBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(PADDING),
          child: Text(
            'Invites',
            style: heading,
          ),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _createJoinBlock() {
    return Padding(
      padding: EdgeInsets.all(PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join Event',
            style: heading,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Event code'),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => debugPrint('beep'),
              child: Text('Join'),
            ),
          ),
        ],
      ),
    );
  }

  _createCreateBlock() {
    return Padding(
      padding: EdgeInsets.all(PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Event',
            style: heading,
          ),
          Padding(padding: EdgeInsets.only(bottom: PADDING),),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => debugPrint('beep'),
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createUpcomingBlock(),
          _createInviteBlock(),
          _createJoinBlock(),
          _createCreateBlock()
        ],
      ),
    );
  }
}
