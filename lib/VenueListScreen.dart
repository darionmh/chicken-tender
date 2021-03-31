import 'package:chickentender/CategoryListWidget.dart';
import 'package:chickentender/CategoryRepository.dart';
import 'package:chickentender/PlacesRepository.dart';
import 'package:chickentender/SearchBox.dart';
import 'package:chickentender/VenueListWidget.dart';
import 'package:chickentender/VenueRepository.dart';
import 'package:flutter/material.dart';

class VenueListScreen extends StatefulWidget {
  @override
  _VenueListScreenState createState() => _VenueListScreenState();
}

class _VenueListScreenState extends State<VenueListScreen> {
  bool isOpen;
  CategoryRepository categoryRepository;
  double _currentSliderValue;
  PlacesRepository placesRepository;
  VenueRepository venueRepository;

  @override
  void initState() {
    super.initState();

    categoryRepository = CategoryRepository.getInstance();
    placesRepository = PlacesRepository.getInstance();
    venueRepository = VenueRepository.getInstance();

    isOpen = false;
    _currentSliderValue = venueRepository.range;
  }

  void showSlideupView(BuildContext context) {
    if (!isOpen) {
      setState(() {
        isOpen = true;
      });
      var bottomSheetController = showBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              width: double.infinity,
              height: 300,
              child: DecoratedBox(
                child: CategoryListWidget(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            );
          });

      bottomSheetController.closed.then((value) {
        setState(() => isOpen = false);
        venueRepository.reloadPlaces.emit();
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (c) {
        if (isOpen) {
          Navigator.pop(context);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    'Chicken Tender',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
          ),
          Padding(
            child: SearchBox(),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          ),
          Padding(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                        'Within ${_currentSliderValue.round()} mile${_currentSliderValue.round() == 1 ? '' : 's'}'),
                    Slider(
                      value: _currentSliderValue,
                      min: 1,
                      max: 50,
                      divisions: 50,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                      onChangeEnd: (value) {
                        venueRepository.range = value;
                        venueRepository.reloadPlaces.emit();
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => showSlideupView(context),
                  child: Row(
                    children: [
                      Text('Filter'),
                      Icon(Icons.menu),
                    ],
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 16, right: 8, bottom: 16),
          ),
          VenueListWidget(),
        ],
      ),
    );
  }
}
