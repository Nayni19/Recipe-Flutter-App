import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false
        });

  void setFilter(Filter filter, bool val) {
    state = {...state, filter: val};
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filterMealsProvider = Provider<List<Meal>>((ref) {
  final meal = ref.watch(mealProvider);
  final filter = ref.watch(filterProvider);

  return meal.where((meal) {
    if (filter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
