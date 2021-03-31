import 'package:chickentender/CategoryRepository.dart';
import 'package:chickentender/Models.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatefulWidget {
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  CategoryRepository categoryRepository;
  Future<List<Category>> futureCategoryList;
  TextEditingController searchController;
  String searchQuery;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    categoryRepository = CategoryRepository.getInstance();

    futureCategoryList = categoryRepository.getCategories();

    searchController = new TextEditingController();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
    searchQuery = '';
  }

  _buildListView(List<Category> categories) {
    var filtered = searchQuery.length > 0
        ? categories
            .where((c) =>
                c.shortName.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList()
        : categories;

    filtered.sort((c1, c2) => c1.selected && !c2.selected ? -1 : c2.selected && !c1.selected ? 1 : c1.shortName.compareTo(c2.shortName));
    return ListView.builder(
      itemCount: filtered.length * 2,
      itemBuilder: (context, index) {
        if (index % 2 == 1) {
          return Row(
            children: [
              SizedBox(
                height: 8,
              ),
            ],
          );
        }

        var category = filtered[index ~/ 2];
        return Row(
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Image.network(category.icon.getImageUrl()),
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Expanded(
              child: Text(category.shortName),
            ),
            Switch(
                value: category.selected,
                onChanged: (val) {
                  setState(() {
                    category.selected = val;
                    categoryRepository.updateCategory(category);
                  });
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategoryList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a search term'),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        (snapshot.data as List<Category>)
                            .forEach((category) => category.selected = false);
                        setState(() {
                          categoryRepository.updateCategories(snapshot.data);
                        });
                      },
                      child: Text('clear all'),
                    ),
                    TextButton(
                      onPressed: () => debugPrint('select'),
                      child: Text('select all'),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(right: 6),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: _buildListView(snapshot.data),
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('${snapshot.error}'),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
