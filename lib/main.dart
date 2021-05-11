import 'package:flutter/material.dart';
import 'package:mealsapp/screens/categories_screen.dart';
import 'package:mealsapp/screens/category_meals_screen.dart';
import 'package:mealsapp/screens/favorites_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/filters_screen.dart';
import 'dummy_data.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  void setFilters(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void toggleFavorite(String mealID) {
    final existingIndex = _favoriteMeals.indexWhere((meal) {
      return meal.id == mealID;
    });
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => mealID == meal.id),
        );
      });
    }
  }

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals),
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        '/category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(setFilters, _filters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) {
          return CategoriesScreen();
        });
      },
    );
  }
}
