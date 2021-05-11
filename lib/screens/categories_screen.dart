import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = "/categories";

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: DUMMY_CATEGORIES.map((item) {
        return CategoryItem(item.title, item.color, item.id);
      }).toList(),
    );
  }
}