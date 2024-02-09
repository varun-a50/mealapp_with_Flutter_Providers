import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp_withprovider/providers/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilteredMealProvider extends StateNotifier<Map<Filter, bool>> {
  FilteredMealProvider()
      : super(

            //we set here filter value globally
            {
              Filter.glutenFree: false,
              Filter.lactoseFree: false,
              Filter.vegetarian: false,
              Filter.vegan: false
            });

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
//state[Filter] = isActive; we cant do this;
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filteredMealProvider =
    StateNotifierProvider<FilteredMealProvider, Map<Filter, bool>>((ref) {
  return FilteredMealProvider();
});

//here the name is bit confusing but  it is for filterd meals
final filteredMealsProvider = Provider((ref) {
  final meal = ref.watch(mealProvider);
  final activeFilter = ref.watch(filteredMealProvider);

  return meal.where((meal) {
    if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
