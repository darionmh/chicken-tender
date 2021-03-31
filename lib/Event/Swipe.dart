import 'package:chickentender/Shared/SharedCard.dart';
import 'package:chickentender/Shared/SimpleMap.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('$id'),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: SharedCard(
          hasPadding: false,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Name', style: body),
                          Text('Category', style: subBody),
                        ],
                      ),
                      Text('Address 1', style: subBody),
                      Text('Address 2', style: subBody),
                      Text('Address 3', style: subBody),
                    ],
                  ),
                  padding: EdgeInsets.all(PADDING),
                ),
              ),
              Expanded(
                child: SizedBox.expand(
                  child: DecoratedBox(
                    child: SimpleMap(lat: 38.9517, lng: -92.3341, marker: Text('Here'),),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (
        direction,
      ) async {
        if (direction == DismissDirection.endToStart) {
          debugPrint('boo');
        } else {
          debugPrint('yas');
        }
        setState(() {
          id += 1;
        });
        // widget.onVote();
      },
      secondaryBackground: DecoratedBox(
        decoration:
            BoxDecoration(color: RED, borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
        ),
      ),
      background: DecoratedBox(
        decoration:
            BoxDecoration(color: GREEN, borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.centerStart,
          child: Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
