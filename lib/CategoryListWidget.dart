import 'package:chickentender/FourSquareRequests.dart';
import 'package:chickentender/Models.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatefulWidget {
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  FourSquareRequests fourSquareRequests;
  Future<CategoriesResponse> futureCategoriesResponse;

  @override
  void initState() {
    super.initState();
    fourSquareRequests = new FourSquareRequests();

    futureCategoriesResponse = fourSquareRequests.fetchCategories();
  }

  _buildListView(CategoriesResponse categoriesResponse) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoriesResponse.categories.length,
      itemBuilder: (context, index) {
        var category = categoriesResponse.categories[index];
        return Image.network(category.icon.getImageUrlWithBackground());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategoriesResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 64,
            child: _buildListView(snapshot.data),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
