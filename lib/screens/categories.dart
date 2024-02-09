import 'package:flutter/material.dart';
import 'package:mealapp_withprovider/data/dummy_data.dart';
import 'package:mealapp_withprovider/models/category.dart';
import 'package:mealapp_withprovider/models/meal.dart';
import 'package:mealapp_withprovider/screens/meals.dart';
import 'package:mealapp_withprovider/widgets/catergory_grid_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  void _selectCategory(
    BuildContext context,
    Category category,
  ) {
    final filteredList = widget.availableMeals
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
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
        builder: (context, child) => SlideTransition(
              position:
                  Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut)),
              child: child,
            ));
  }
}
