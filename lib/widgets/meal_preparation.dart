import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/provider/favourites_provider.dart';
import 'package:meals_app/widgets/ingredient_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealPreparation extends ConsumerWidget {
  const MealPreparation({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var favoriteMeals = ref.watch(favoriteMealsProvider);
    bool isFav = favoriteMeals.contains(meal);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              for (var ingredient in meal.ingredients)
                IngredientTab(ingredient: ingredient)
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Steps to Prepare',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          for (var step in meal.steps)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                step,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                    Theme.of(context).colorScheme.onPrimaryContainer),
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Theme.of(context).colorScheme.primaryContainer),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(400, 50)),
              ),
              onPressed: () {
                ref.read(favoriteMealsProvider.notifier).toggleNotifier(meal);
              },
              icon: isFav
                  ? const Icon(Icons.favorite_border_sharp)
                  : const Icon(Icons.favorite),
              label: isFav
                  ? const Text('Remove from Favorites')
                  : const Text('Mark as Favorite'),
            ),
          )
        ],
      ),
    );
  }
}
