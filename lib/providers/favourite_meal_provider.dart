import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp_withprovider/models/meal.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]);
  bool favoriteMealproviderToggle(Meal meal) {
    //here we are checking if the list has the new id or not
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      //we are removing from list by matching the id of meal
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) {
  return FavoriteMealNotifier();
});
