import 'dart:convert';
import 'dart:developer';
import 'package:chickentender/VenuesResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class VenueRepository {
  final String _id = env['ID'];
  final String _secret = env['SECRET'];
  final String _v = env['V'];

  Future<VenuesResponse> fetchVenues() async {
    final response = await http.get(
        Uri.https(
            'api.foursquare.com',
            'v2/venues/search',
            // {'client_id': _id, 'client_secret': _secret, 'v': _v, 'intent': 'browse', 'radius': '100000', 'categoryId': '4bf58dd8d48988d14e941735', 'near': 'Columbia, MO'}
            {'client_id': _id, 'client_secret': _secret, 'v': _v, 'intent': 'browse', 'radius': '100000', 'categoryId': '4bf58dd8d48988d14e941735', 'll': '38.9517,-92.3341'}
        ));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var body = jsonDecode(response.body);
      if(body['meta']['code'] == 200) {
        // debugPrint('$body');
        return new VenuesResponse.fromJson(body['response']);
      } else {
        throw Exception('Failed to load venues');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load venues');
    }
  }
}