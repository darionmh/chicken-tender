import 'dart:convert';

import 'package:chickentender/EventEmitter.dart';
import 'package:chickentender/Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PlacesRepository extends Repository {
  final String _key = env['PLACES_KEY'];

  PlacesRepository() :
      super();

  Future<PlacesResponse> fetchPredictions(query) async {
    var response = checkCache(query) ?? await http.get(
        Uri.https(
            'maps.googleapis.com',
            'maps/api/place/autocomplete/json',
            // {'key': _key, 'types': 'address', 'input': query}
            {'key': _key, 'types': '(cities)', 'input': query}
        ));
    updateCache(query, response);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var body = jsonDecode(response.body);
      // debugPrint(body.toString());
      return new PlacesResponse.fromJson(body);
    } else {
      // debugPrint(response.body);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load venues');
    }
  }

  static PlacesRepository _instance;

  static PlacesRepository getInstance() {
    if(_instance == null) {
      _instance = new PlacesRepository();
    }

    return _instance;
  }
}

class PlacesResponse {
  List<Prediction> predictions;

  PlacesResponse({this.predictions});

  PlacesResponse.fromJson(Map<String, dynamic> json) {
    predictions = [];
    if(json['predictions'] != null) {
      json['predictions'].forEach((p) => predictions.add(Prediction.fromJson(p)));
    }
  }

  @override
  String toString() {
    return predictions.toString();
  }
}

class Prediction {
  String description;

  Prediction({this.description});

  Prediction.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  @override
  String toString() {
    return '\'$description\'';
  }
}