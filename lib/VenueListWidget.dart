import 'package:chickentender/CategoryRepository.dart';
import 'package:chickentender/PlacesRepository.dart';
import 'package:chickentender/VenueRepository.dart';
import 'package:chickentender/Models.dart';
import 'package:chickentender/VenueTile.dart';
import 'package:flutter/material.dart';

class VenueListWidget extends StatefulWidget {
  VoidCallback shouldReload;

  VenueListWidget({key, this.shouldReload}) : super(key: key);

  @override
  _VenueListWidgetState createState() => _VenueListWidgetState();
}

class _VenueListWidgetState extends State<VenueListWidget> {
  VenueRepository venueRepository;
  Future<VenuesResponse> futureVenuesResponse;
  CategoryRepository categoryRepository;
  PlacesRepository placesRepository;

  VoidCallback _unsub;

  List<String> voted;

  @override
  void dispose() {
    _unsub();
    super.dispose();
  }

  @override
  void initState() {
    venueRepository = VenueRepository.getInstance();
    categoryRepository = CategoryRepository.getInstance();
    placesRepository = PlacesRepository.getInstance();

    futureVenuesResponse = venueRepository.fetchVenues();
    _unsub =
        venueRepository.reloadPlaces.subscribe(() => setState(() {
              futureVenuesResponse = venueRepository.fetchVenues();
              voted = [];
            }));

    voted = [];
    super.initState();
  }

  Widget _buildListView(VenuesResponse venuesResponse) {
    final venues = venuesResponse.venues.where((v) => !voted.contains(v.id)).toList();

    if(venues.length == 0){
      return Text('No results.');
    }
    venues.sort((a, b) {
      if(a.location.distance != null && b.location.distance != null) {
        if(a.location.distance < b.location.distance) {
          return -1;
        } else if(a.location.distance > b.location.distance) {
          return 1;
        }
      }
      return a.name.compareTo(b.name);
    });

    return ListView.builder(
        itemCount: venues.length,
        itemBuilder: (context, index) {
          var venue = venues[index];
          return VenueTile(key: Key(venue.id), venue: venue, onVote: () {
            setState(() {
              voted.add(venue.id);
            });
          },);
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureVenuesResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(child: _buildListView(snapshot.data));
        } else if (snapshot.hasError) {
          return Expanded(child: Text('${snapshot.error}'));
        }

        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
