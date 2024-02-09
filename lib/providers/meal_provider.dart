import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp_withprovider/data/dummy_data.dart';

final mealProvider = Provider((ref) {
  return dummyMeals;
});
