import 'package:chickentender/Models.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class VenueTile extends StatefulWidget {
  Venue venue;
  VoidCallback onVote;

  VenueTile({key, this.venue, this.onVote}) : super(key: key);

  @override
  _VenueTileState createState() => _VenueTileState(venue: venue);
}

class _VenueTileState extends State<VenueTile> {
  Venue venue;

  _VenueTileState({this.venue});

  @override
  Widget build(BuildContext context) {
    var address = venue.location.formattedAddress.map((e) => Text(e)).toList();
    address.removeLast();

    return Dismissible(
      key: Key(venue.id),
      onDismissed: (direction, ) async {
        if (direction == DismissDirection.startToEnd) {
          debugPrint('boo');
        } else {
          debugPrint('yas');
        }

        widget.onVote();
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerStart,
        child: Icon(
          Icons.close_rounded,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green[700],
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        key: Key(venue.id),
        title: Text('${venue.name}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(venue.categories.map((c) => c.shortName).join(', ')),
            ...address,
            if (venue.location.distance != null)
              Text(
                  '${(venue.location.distance * 0.00062).toStringAsPrecision(2)} miles')
          ],
        ),
        trailing: SizedBox(
          width: 32,
          height: 32,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Image.network(venue.categories[0].icon.getImageUrl()),
          ),
        ),
      ),
    );
  }
}
