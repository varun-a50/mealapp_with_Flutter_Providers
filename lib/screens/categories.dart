import 'package:flutter/material.dart';
import 'package:mealapp_withprovider/data/dummy_data.dart';
import 'package:mealapp_withprovider/models/category.dart';
import 'package:mealapp_withprovider/models/meal.dart';
import 'package:mealapp_withprovider/screens/meals.dart';
import 'package:mealapp_withprovider/widgets/catergory_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredList = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealScreen(
                  title: category.title,
                  meals: filteredList,
                )));
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          //Alternative to availableCategories.map((catergory) => CategoryGridItem(category: category) ).toList();
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
