import 'package:chickentender/VenueRepository.dart';
import 'package:chickentender/VenuesResponse.dart';
import 'package:flutter/material.dart';

class VenueListWidget extends StatefulWidget {
  @override
  _VenueListWidgetState createState() => _VenueListWidgetState();
}

class _VenueListWidgetState extends State<VenueListWidget> {
  VenueRepository venueRepository;
  Future<VenuesResponse> futureVenuesResponse;

  @override
  void initState() {
    super.initState();
    venueRepository = new VenueRepository();

    futureVenuesResponse = venueRepository.fetchVenues();
  }

  ListView _buildListView(VenuesResponse venuesResponse) {
    debugPrint('${venuesResponse.venues}');
    return ListView.builder(
        itemCount: venuesResponse.venues.length,
        itemBuilder: (context, index) {
          var venue = venuesResponse.venues[index];
          return ListTile(
              key: Key(venue.id),
              title: Text('${venue.name}'),
              subtitle: Text('${venue.location.address}, ${venue.location.city}, ${venue.location.state} (${venue.location.distance}m)'),
              trailing: Icon(Icons.ac_unit),
          );
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
            return Text('${snapshot.error}');
          }

          return CircularProgressIndicator();
        });
  }
}
