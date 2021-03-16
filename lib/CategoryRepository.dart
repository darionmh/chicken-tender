import 'package:chickentender/FourSquareRequests.dart';
import 'package:chickentender/Models.dart';

class CategoryRepository {
  List<Category> _categories;

  Future<List<Category>> getCategories() async {
    if (_categories == null) {
      CategoriesResponse response =
          await FourSquareRequests().fetchCategories();
      _categories = response.categories;
    }

    return _categories;
  }

  Future<List<Category>> getCategoriesForFood() async {
    return (await getCategories())
        .where((c) => c.name == 'Food' || c.name == 'Nightlife Spot')
        .expand((e) => e.subCategories)
        .toList();
  }

  void updateCategory(Category category) {
    var i = _categories.indexWhere((c) => c.id == category.id);
    if (i >= 0) {
      _categories[i] = category;
    }
  }

  static CategoryRepository instance;

  static CategoryRepository getInstance() {
    if (instance == null) {
      instance = new CategoryRepository();
    }

    return instance;
  }
}
