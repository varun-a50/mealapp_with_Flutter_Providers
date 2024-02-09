import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp_withprovider/models/meal.dart';
import 'package:mealapp_withprovider/providers/favourite_meal_provider.dart';
import 'package:mealapp_withprovider/providers/meal_provider.dart';
import 'package:mealapp_withprovider/screens/categories.dart';
import 'package:mealapp_withprovider/screens/fliters.dart';
import 'package:mealapp_withprovider/screens/meals.dart';
import 'package:mealapp_withprovider/widgets/main_drawer.dart';
import 'package:mealapp_withprovider/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  var activePageTitle = 'Categories';

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoryScreen(
      availableMeals: availableMeals,
    );

//We are reusing MealsScreen so understand the logic 165
//favoritemealprovider user
    if (_selectedPageIndex == 1) {
      final favoriteMealProvider = ref.watch(favouriteMealProvider);
      activePage = MealScreen(
        meals: favoriteMealProvider,
      );
      activePageTitle = 'Your Favorites';
    } else {
      activePageTitle = 'Categories';
    }
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
        onTap: _selectPage,
      ),
    );
  }
}
