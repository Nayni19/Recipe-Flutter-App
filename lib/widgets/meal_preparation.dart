import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/ingredient_tab.dart';

class MealPreparation extends StatelessWidget {
  const MealPreparation({
    super.key,
    required this.meal,
    required this.onToggle,
  });

  final Meal meal;
  final Function onToggle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
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
                    (states) => Size(400, 50)),
              ),
              onPressed: () {
                onToggle(meal);
              },
              icon: Icon(Icons.favorite),
              label: Text('Mark as Favorite'),
            ),
          )
        ],
      ),
    );
  }
}
