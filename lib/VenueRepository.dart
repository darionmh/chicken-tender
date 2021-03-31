import 'dart:convert';
import 'dart:developer';
import 'package:chickentender/CategoryRepository.dart';
import 'package:chickentender/EventEmitter.dart';
import 'package:chickentender/Models.dart';
import 'package:chickentender/PlacesRepository.dart';
import 'package:chickentender/Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class VenueRepository extends Repository{
  final String _id = env['ID'];
  final String _secret = env['SECRET'];
  final String _v = env['V'];

  double range = 10;
  String currentLocation;
  double lat;
  double lng;

  PlacesRepository placesRepository;
  EventEmitter reloadPlaces;

  VenueRepository() :
        placesRepository = PlacesRepository.getInstance(),
        reloadPlaces = new EventEmitter(),
        super();

  Future<VenuesResponse> fetchVenues() async {
    var categories = await CategoryRepository.getInstance().getSelectedCategories();
    var categoryQuery = categories.length > 0 ? categories.map((c) => c.id).join(',') : '4d4b7105d754a06374d81259,4d4b7105d754a06376d81259';

    var params = {'client_id': _id, 'client_secret': _secret, 'v': _v, 'intent': 'browse', 'radius': '${(range * 1609.34).round()}', 'categoryId': categoryQuery};

    var location;
    if(lat != null && lng != null) {
      currentLocation = 'Current Location';
      params['ll'] = '$lat,$lng';
      location = params['ll'];
    } else {
      params['near'] = currentLocation;
      location = params['near'];
    }

    if(location == null) {
      return new VenuesResponse(venues: []);
    }

    var cacheKey = categoryQuery+'.'+location+'.$range';

    var response = checkCache(cacheKey) ?? await http.get(
        Uri.https(
            'api.foursquare.com',
            'v2/venues/search',
            params
        ));
    updateCache(cacheKey, response);

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
        // debugPrint(response.body);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load venues');
    }
  }

  static VenueRepository _instance;

  static VenueRepository getInstance() {
    if(_instance == null) {
      _instance = new VenueRepository();
    }

    return _instance;
  }
}