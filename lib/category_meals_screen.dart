import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  final String id;
  final String title;

  const CategoryMealsScreen(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.pink,
      ),
      body: const Center(
        child: Text('The recipies for the category!'),
      ),
    );
  }
}
