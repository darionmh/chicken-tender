import 'package:chickentender/FourSquareRequests.dart';
import 'package:chickentender/Models.dart';
import 'package:flutter/material.dart';

class VenueListWidget extends StatefulWidget {
  @override
  _VenueListWidgetState createState() => _VenueListWidgetState();
}

class _VenueListWidgetState extends State<VenueListWidget> {
  FourSquareRequests venueRepository;
  Future<VenuesResponse> futureVenuesResponse;

  @override
  void initState() {
    super.initState();
    venueRepository = new FourSquareRequests();

    futureVenuesResponse = venueRepository.fetchVenues();
  }

  ListView _buildListView(VenuesResponse venuesResponse) {
    return ListView.builder(
        itemCount: venuesResponse.venues.length,
        itemBuilder: (context, index) {
          var venue = venuesResponse.venues[index];
          return ListTile(
              key: Key(venue.id),
              title: Text('${venue.name}'),
              subtitle: Text('${venue.location.address}, ${venue.location.city}, ${venue.location.state} (${venue.location.distance}m)'),
              trailing: SizedBox(
                width: 32,
                height: 32,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Image.network(venue.categories[0].icon.getImageUrl()),
                ),
              ),
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
