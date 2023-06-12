import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = 'meal-details';

  final Function toggleFavourite;
  final Function isFavourite;

  const MealDetailsScreen({
    super.key,
    required this.toggleFavourite,
    required this.isFavourite,
  });

  Widget buildSectionTitle(String title, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Card(
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          selectedMeal.ingredients[index],
                        ),
                      ),
                    ),
                itemCount: selectedMeal.ingredients.length)),
            buildSectionTitle('Steps', context),
            buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${index + 1}'),
                          ),
                          title: Text(
                            selectedMeal.steps[index],
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                itemCount: selectedMeal.ingredients.length)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavourite(mealId),
        child: Icon(
          isFavourite(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
