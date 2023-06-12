import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';
import '../screens/settings_screen.dart';
import '../screens/meal_details_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }

        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final int existingMealIdx =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingMealIdx >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingMealIdx);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavourite(String mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          appBarTheme: const AppBarTheme(
            color: Colors.pink,
          ),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          useMaterial3: true,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyMedium: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                titleLarge: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
      routes: {
        '/': (ctx) => TabsScreen(favouriteMeals: _favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(
            toggleFavourite: _toggleFavourite, isFavourite: _isFavourite),
        SettingsScreen.routeName: (ctx) => SettingsScreen(
              currentSettings: _filters,
              saveFilters: _setFilters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
