import 'dart:convert';

import 'package:chickentender/EventEmitter.dart';
import 'package:chickentender/Repository.dart';
import 'package:chickentender/VenueRepository.dart';
import 'package:chickentender/Models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryRepository extends Repository {
  final String _id = env['ID'];
  final String _secret = env['SECRET'];
  final String _v = env['V'];

  List<Category> _categories;

  CategoryRepository() :
        super();

  Future<CategoriesResponse> fetchCategories() async {
    var response = checkCache('fetchCategories') ??
        await http.get(Uri.https('api.foursquare.com', 'v2/venues/categories',
            {'client_id': _id, 'client_secret': _secret, 'v': _v}));
    updateCache('fetchCategories', response);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var body = jsonDecode(response.body);
      if (body['meta']['code'] == 200) {
        // debugPrint('$body');
        return new CategoriesResponse.fromJson(body['response']);
      } else {
        throw Exception('Failed to load venues');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load venues');
    }
  }

  Future<List<Category>> getAllCategories() async {
    CategoriesResponse response = await fetchCategories();
    return response.categories;
  }

  Future<List<Category>> getCategories() async {
    if (_categories == null) {
      _categories = (await getAllCategories())
          .where((c) => c.name == 'Food' || c.name == 'Nightlife Spot')
          .expand((e) => e.subCategories)
          .toList();
    }

    return _categories;
  }

  Future<List<Category>> getSelectedCategories() async {
    return (await getCategories()).where((c) => c.selected).toList();
  }

  void updateCategory(Category category) {
    var i = _categories.indexWhere((c) => c.id == category.id);
    if (i >= 0) {
      _categories[i] = category;
    }
  }

  void updateCategories(List<Category> categories) {
    _categories = categories.toList();
  }

  static CategoryRepository _instance;

  static CategoryRepository getInstance() {
    if (_instance == null) {
      _instance = new CategoryRepository();
    }

    return _instance;
  }
}
