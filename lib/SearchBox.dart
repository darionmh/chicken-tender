import 'package:chickentender/PlacesRepository.dart';
import 'package:chickentender/VenueRepository.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController locationSearchController;
  PlacesRepository placesRepository;
  VenueRepository venueRepository;
  final FocusNode _focusNode = FocusNode();
  OverlayEntry _overlayEntry;
  List<Prediction> locationPredictions;

  @override
  void dispose() {
    locationSearchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    placesRepository = PlacesRepository.getInstance();
    venueRepository = VenueRepository.getInstance();

    locationSearchController = new TextEditingController();

    if (venueRepository.currentLocation != null) {
      locationSearchController.text = venueRepository.currentLocation;
    }

    locationSearchController.addListener(() {
      // debugPrint('update');
      if (locationSearchController.text.length > 2) {
        placesRepository
            .fetchPredictions(locationSearchController.text)
            .then((value) {
          setState(() {
            locationPredictions = value.predictions;
            if (_focusNode.hasFocus && this._overlayEntry != null) {
              this._overlayEntry.remove();
              this._overlayEntry = this._createOverlayEntry();
              Overlay.of(context).insert(this._overlayEntry);
            }
          });
        });
      } else {
        setState(() {
          locationPredictions = [];
        });
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      } else if (this._overlayEntry != null) {
        this._overlayEntry.remove();
        this._overlayEntry = null;
      }
    });

    locationPredictions = [];

    super.initState();
  }

  void _setLocation(String location, bool update) {
    if (this._overlayEntry != null) {
      this._overlayEntry.remove();
      this._overlayEntry = null;
    }
    this.locationSearchController.text = location;
    if(update) {
      this.venueRepository.lng = null;
      this.venueRepository.lat = null;
      this.venueRepository.currentLocation = location;
      this.venueRepository.reloadPlaces.emit();
    }
    this._focusNode.unfocus();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 5.0,
              width: size.width,
              child: Material(
                elevation: 4.0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: GestureDetector(
                        onTap: () async {
                          Location location = new Location();

                          bool _serviceEnabled;
                          PermissionStatus _permissionGranted;
                          LocationData _locationData;

                          _serviceEnabled = await location.serviceEnabled();
                          if (!_serviceEnabled) {
                            _serviceEnabled = await location.requestService();
                            if (!_serviceEnabled) {
                              debugPrint('service not enabled');
                              return;
                            }
                          }

                          _permissionGranted = await location.hasPermission();
                          if (_permissionGranted == PermissionStatus.denied) {
                            _permissionGranted =
                                await location.requestPermission();
                            if (_permissionGranted !=
                                PermissionStatus.granted) {
                              debugPrint('permission not granted');
                              return;
                            }
                          }

                          _locationData = await location.getLocation();
                          debugPrint(_locationData.toString());
                          debugPrint('${_locationData.latitude}, ${_locationData.longitude}');
                          venueRepository.lat = _locationData.latitude;
                          venueRepository.lng = _locationData.longitude;
                          venueRepository.currentLocation = null;
                          venueRepository.reloadPlaces.emit();
                          _setLocation('Current Location', false);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            Text('Use current location'),
                          ],
                        ),
                      ),
                    ),
                    ...locationPredictions
                        .map(
                          (location) => GestureDetector(
                            onTap: () => _setLocation(location.description, true),
                            child: ListTile(
                              title: Text(location.description),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: locationSearchController,
      focusNode: this._focusNode,
      decoration: InputDecoration(
        labelText: 'Location',
        // suffix: TextButton(
        //   child: Text('clear'),
        // ),
      ),
    );
  }
}
