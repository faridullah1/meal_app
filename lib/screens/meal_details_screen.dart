import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = 'meal-details';

  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Details'),
      ),
      body: Text('Meal detail of $mealId'),
    );
  }
}
